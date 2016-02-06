class PlansController < ApplicationController
  before_action :authenticate_user!

  def show
    @plan = Plan.find(params[:id])
  end

  def new
    @meeting = Meeting.find(params[:id])
    @plan = Plan.new
    @badges = @meeting.cycle.badges
    @badge_requirements = []
    @badges.each do |b|
      @badge_requirements += b.badge_requirements.collect{|b| [b.description, b.id]}
    end
    @plan.plan_points << PlanPoint.new(task_name: '1', task_info: '2', task_time: '3')
    @plan.plan_points << PlanPoint.new(task_name: '1', task_info: '2', task_time: '3')
    @plan.plan_points << PlanPoint.new(task_name: '1', task_info: '2', task_time: '3')
    @plan.plan_points << PlanPoint.new(task_name: '1', task_info: '2', task_time: '3')
    add_breadcrumb "Plany", :year_plans_path
    add_breadcrumb "Cykle", year_plan_path(@meeting.cycle.year_plan)
    add_breadcrumb 'Zbiórki', cycle_path(@meeting.cycle)
    add_breadcrumb 'Nowa zbiórka', new_meeting_path(@meeting.cycle)
  end

  def create
    @meeting = Meeting.find(params[:id])
    @badges = @meeting.cycle.badges
    @badge_requirements = []
    @badges.each do |b|
      @badge_requirements += b.badge_requirements.collect{|b| [b.description, b.id]}
    end
    @plan = Plan.new(plan_params)
    @plan.meeting = @meeting
    @plan.save
    render :new
  end


  def edit
    @plan = Plan.find(params[:id])
    @meeting = @plan.meeting
    @badges = @meeting.cycle.badges
    @badge_requirements = []
    @badges.each do |b|
      @badge_requirements += b.badge_requirements.collect{|b| [b.description, b.id]}
    end
  end

  def update
    @plan = Plan.find(params[:id])
    @meeting = @plan.meeting
    @badges = @meeting.cycle.badges
    @badge_requirements = []
    @badges.each do |b|
      @badge_requirements += b.badge_requirements.collect{|b| [b.description, b.id]}
    end
    @plan.update(plan_params)
    render :edit
  end

  def destroy
    @plan = Plan.find(params[:id])
    @cycle = @plan.meeting.cycle
    @plan.destroy
    redirect_to cycle_path(@cycle)
  end

  def finish_up
    @meeting = Meeting.find(params[:id])
    @meeting.summed_up = true
    @meeting.user_ids = plan_params[:user_ids]
    @meeting.save
    users = User.where(id: params[:plan][:user_ids])
    users.each do |u|
      plan_points = PlanPoint.where(id: params[:plan][:users][u.id.to_s][:plan_points])
      plan_points.each do |pp|
        u.plan_points << pp
        u.badge_requirements << pp.badge_requirements
      end
      u.save
    end
    # params[:plan][:users].each do |u|
    #   user = User.find(u[0])
    #   PlanPoint.where(id: u[1]['plan_points']).each do |pp|
    #     user.badge_requirements << pp.badge_requirements
    #   end
    #   user.save
    # end
    redirect_to root_path, notice: 'Podsumowane!'
  end

  def plan_params
    params.require(:plan).permit(:name, :start_date, :stop_date, user_ids: [], plan_point_ids:[], plan_points_attributes: [:id, :task_name, :task_time, :task_info, :materials_needed, :person_responsible, :_destroy, badge_requirement_ids:[] ], users: [plan_points: [:_destroy]])
  end


end