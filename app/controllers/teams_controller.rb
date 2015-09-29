# coding: UTF-8

class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :make_sure_team_is_mine, only: [:show]

  def index
    @teams = current_user.lead_teams
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user
    if @team.save
      redirect_to root_path
    else
      render :new 
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      redirect_to root_path
    else
      render :new 
    end
  end

  def show
    @team = current_user.lead_teams.find(params[:id])
    @users = @team.scouts.active
    render :template => 'users/index'
  end

  def add_team_group
    @team = Team.find(params[:id])
    @team_group = TeamGroup.new
  end

  def create_team_group
    @team = Team.find(params[:team_group][:team_id])
    @team_group = TeamGroup.new(team_group_params)
    if @team_group.save
      redirect_to teams_path, notice: 'Szóstka stworzona'
    else
      render :add_team_group, alert: 'Nie udało się!'
    end

  end

  def archive
    @team = Team.find(params[:id])
    @users = @team.scouts.inactive
    render :template => 'users/index'
  end

  def edit_team_group
    @team_group = TeamGroup.find(params[:id])
  end

  def update_team_group
    @team_group = TeamGroup.find(params[:id])
    if @team_group.update(team_group_params)
      redirect_to teams_path, notice: 'Szóstka zaktualizowana'
    else
      redirect_to teams_path, alert: 'Szóstka nie zaktualizowana'
    end
  end


  def add_scout
    @badges = Badge.all
    @team = Team.find(params[:id])
    @team_groups = @team.team_groups.pluck(:name, :id)
    @user = User.new
  end

  def create_scout
    @team = Team.find(params[:user][:team_id])
    @team_groups = @team.team_groups.pluck(:name, :id)
    @user = User.new(user_params)
    @user.set_archived_false
    @user.signing_in = false
    @badges = Badge.all
    @user.password = 'lolopolo'
    if @user.save
      redirect_to team_path(@team), notice: 'User stworzony'
    else
      render :add_scout, alert: 'Nie udało się!'
    end

  end

  def edit_scout
    @user = User.find(params[:id])
    @user.signing_in = false
    @team_groups = @user.team.team_groups.pluck(:name, :id)
    @badges = Badge.all
  end

  def update_scout
    @user = User.find(params[:id])
    @user.signing_in = false
    @badges = Badge.all
    if @user.update(user_params)
      redirect_to team_edit_scout_path(@user), notice: 'Zuch zaktualizowany'
    else
      redirect_to team_edit_scout_path(@user), alert: 'Zuch nie zaktualizowany'
    end
  end


  def start_trial
    @user=User.find(params[:id])
    @user.trials << Trial.new(rank: Rank.find_by(level: @user.stars+1))
  end

  def team_group_params
    params.require(:team_group).permit(:name, :team_id)
  end

  def team_params
    params.require(:team).permit(:name, :history, :situation_description, :base, :adjutant_1, :adjutant_2, :banner, :chapter, :date_of_creation, :ceremonial)
  end

  def user_params
    params.require(:user).permit(:first_name, :team_id, :last_name, :description, :scouts_mark, :date_of_admission, :date_of_leave, :phone_number, :parent_1, :parent_2, :parent_1_phone, :parent_1_email, :parent_2_email, :parent_2_phone, :team_group_id, :birth_date, badge_ids: [], custom_task_ids: [])
  end

  private

  def make_sure_team_is_mine
    unless current_user.lead_teams.find_by(id: params[:id])
      redirect_to '/', alert: 'Nie masz uprawnień'
      return
    end
    true
  end

end
