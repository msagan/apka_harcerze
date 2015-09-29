class CyclesController < ApplicationController
  before_action :authenticate_user!

  def index
    @teams = current_user.lead_teams
  end

  def show
    @cycle = Cycle.find(params[:id])
    add_breadcrumb "Plany", :year_plans_path
    add_breadcrumb "Cykle", year_plan_path(@cycle.year_plan)
    add_breadcrumb 'Spotkania', cycles_path(@cycle)
  end

  def new    
    @year_plan = YearPlan.find(params[:id])
    @cycle = Cycle.new
    @badges = @year_plan.badges
    add_breadcrumb "Plany", :year_plans_path
    add_breadcrumb "Cykle", cycles_path
    add_breadcrumb "Nowy cykl", new_cycle_path(@year_plan)
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
    @year_plan = @cycle.year_plan
    @badges = @year_plan.badges
  end

  def update
    @cycle = Cycle.find(params[:id])
    @year_plan = @cycle.year_plan
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
    params.require(:cycle).permit(:name, :team_id, :start_date, :stop_date, badge_ids:[])
  end


end