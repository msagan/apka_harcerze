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
    add_breadcrumb "Plany", :year_plans_path
    add_breadcrumb "Cykle", year_plan_path(@meeting.cycle.year_plan)
    add_breadcrumb 'Spotkania', cycle_path(@meeting.cycle)
    add_breadcrumb 'Nowe spotkane', new_meeting_path(@meeting.cycle)
  end

  def create
    @meeting = Meeting.find(params[:id])
    @plan = Plan.new(plan_params)
    @plan.meeting = @meeting
    if @plan.save
      redirect_to cycle_path(@meeting.cycle), notice: "Spotkanie dodane"
    else
      redirect_to cycle_path(@meeting.cycle)
    end
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
    if @plan.update(plan_params)
      redirect_to cycle_path(@plan.meeting.cycle), notice: "Spotkanie zmienione"
    else
      redirect_to cycle_path(@plan.meeting.cycle)
    end
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
    params[:plan][:users].each do |u|
      user = User.find(u[0])
      PlanPoint.where(id: u[1]['plan_points']).each do |pp|
        user.badge_requirements << pp.badge_requirements
      end
      user.save
    end
    redirect_to root_path, notice: 'Podsumowane!'
  end

  def plan_params
    params.require(:plan).permit(:name, :start_date, :stop_date, user_ids: [], plan_point_ids:[], plan_points_attributes: [:id, :task_name, :task_time, :task_info, :materials_needed, :person_responsible, :_destroy, badge_requirement_ids:[] ], users: [plan_points: []])
  end


end