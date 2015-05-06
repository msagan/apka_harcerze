class YearPlansController < ApplicationController
  before_action :authenticate_user!

  def index
    @teams = current_user.lead_teams
  end

  def show
    @teams = current_user.lead_teams
    @year_plan = YearPlan.find(params[:id])
  end

  def new
    @teams = current_user.lead_teams
    @badges = Badge.all
    @year_plan = YearPlan.new
  end

  def create
    if @year_plan = YearPlan.create(year_plan_params)
      redirect_to year_plans_path, notice: "Cykl dodany"
    else
      redirect_to year_plans_path
    end
  end

  def edit
    @badges = Badge.all
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
    YearPYearPlanlan.find(params[:id]).destroy
    redirect_to year_plans_path
  end

  def year_plan_params
    params.require(:year_plan).permit(:title, :team_id, badge_ids:[])
  end


end