class PlansController < ApplicationController
  before_action :authenticate_user!

  def show
    @plan = Plan.find(params[:id])
  end

  def new
    @meeting = Meeting.find(params[:id])
    @plan = Plan.new
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
    @meeting = Meeting.find(params[:id])
    @plan = Plan.find(params[:id])
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
    @plan.destroy
    redirect_to cycle_path(@cycle)
  end

  def plan_params
    params.require(:plan).permit(:name, :start_date, :stop_date, plan_points_attributes: [:id, :task_name, :task_time, :task_info, :materials_needed, :person_responsible, :_destroy])


  end


end