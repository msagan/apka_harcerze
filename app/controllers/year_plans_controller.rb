class YearPlansController < ApplicationController
  before_action :authenticate_user!

  def index
    @teams = current_user.lead_teams
    add_breadcrumb "Plany", :year_plans_path
  end

  def show
    @teams = current_user.lead_teams
    @year_plan = YearPlan.find(params[:id])
    add_breadcrumb "Plany", :year_plans_path
    add_breadcrumb "Cykle", year_plans_path(@year_plan)
  end

  def new
    @teams = current_user.lead_teams
    @badges = @teams.first.get_team_badges
    @year_plan = YearPlan.new
  end

  def create
    @year_plan = YearPlan.new(year_plan_params)
    @year_plan.team_id = current_user.lead_teams.first.id
    if @year_plan.save
      redirect_to year_plans_path, notice: "Cykl dodany"
    else
      redirect_to year_plans_path
    end
  end

  def edit
    @badges = @teams.first.get_team_badges
    @teams = current_user.lead_teams
    @year_plan = YearPlan.find(params[:id])
  end

  def update
    @year_plan = YearPlan.find(params[:id])
    if @year_plan.update(year_plan_params)
      redirect_to year_plans_path, notice: "Cykl dodany"
    else
      redirect_to year_plans_path
    end
  end

  def destroy
    YearPlan.find(params[:id]).destroy
    redirect_to year_plans_path
  end

  def year_plan_params
    params.require(:year_plan).permit(:title, badge_ids:[])
  end


end