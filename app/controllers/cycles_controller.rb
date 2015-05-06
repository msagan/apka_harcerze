class CyclesController < ApplicationController
  before_action :authenticate_user!

  def index
    @teams = current_user.lead_teams
  end

  def show
    @cycle = Cycle.find(params[:id])
  end

  def new
    @year_plan = YearPlan.find(params[:id])
    @cycle = Cycle.new
  end

  def create
    @year_plan = YearPlan.find(params[:id])
    if @year_plan.cycles << Cycle.create(cycle_params)
      redirect_to year_plan_path(@year_plan), notice: "Cykl dodany"
    else
      redirect_to year_plan_path(@year_plan)
    end
  end

  def edit
    @cycle = Cycle.find(params[:id])
  end

  def update
    @year_plan = YearPlan.find(params[:id])
    @cycle = Cycle.find(params[:id])
    if @cycle.update(cycle_params)
      redirect_to year_plan_path(@year_plan), notice: "Cykl dodany"
    else
      redirect_to year_plan_path(@year_plan)
    end
  end

  def destroy
    Cycle.find(params[:id]).destroy
    redirect_to :back
  end

  def cycle_params
    params.require(:cycle).permit(:name, :team_id, :start_date, :stop_date)
  end


end