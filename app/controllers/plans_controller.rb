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
  end

  def create
    @meeting = Meeting.find(params[:id])
    @meeting.plan = Plan.create(plan_params)
    if @meeting.save
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
    users = User.find(params[:plan][:user_ids])
    brs = PlanPoint.where(id: params[:plan][:plan_point_ids]).pluck(:badge_requirement_id)
    users.each do |u|
      u.badge_requirement_ids = u.badge_requirement_ids | brs
      u.save
    end
    redirect_to root_path, notice: 'Podsumowane!'
  end



  def plan_params
    params.require(:plan).permit(:name, :start_date, :stop_date, user_ids: [], plan_point_ids:[], plan_points_attributes: [:id, :task_name, :task_time, :task_info, :badge_requirement_id, :materials_needed, :person_responsible, :_destroy])


  end


end