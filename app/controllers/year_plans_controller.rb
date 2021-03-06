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
    add_breadcrumb "Plany", :year_plans_path
    add_breadcrumb "Nowy plan", year_plans_path(@year_plan)
    @teams = current_user.lead_teams
    @badges = @teams.first.get_team_badges
    # @badges = @badges.sort_by{|item| [ item[0].color ]}
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

  def show_year_plan
    @year_plan.find(params[:id])
  end

  def edit
    @teams = current_user.lead_teams
    @badges = @teams.first.get_team_badges
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
    params.require(:year_plan).permit(:title, :situation_description, badge_ids:[])
  end


end