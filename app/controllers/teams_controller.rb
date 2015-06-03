# coding: UTF-8

class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :make_sure_team_is_mine, only: [:show]

  def index
    @teams = current_user.lead_teams
  end

  def show
    @team = current_user.lead_teams.find(params[:id])
    @users = @team.scouts
    render :template => 'users/index'
  end

  def add_scout
    @team = Team.find(params[:id])
    @user = User.new
  end

  def create_scout
    @team = Team.find(params[:user][:team_id])
    @user = User.new(user_params)
    @user.password = 'lolopolo'
    if @user.save
      redirect_to team_path(@team), notice: 'User stworzony'
    else
      render :add_scout, alert: 'Nie udało się!'
    end

  end

  def edit_scout
    @user = User.find(params[:id])
    
  end

  def update_scout
    @user = User.find(params[:id])
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

  def team_params
    params.require(:team).permit(:name, :history, :situation_description)
  end

  def user_params
    params.require(:user).permit(:first_name, :email, :last_name, :stars, :description, :pesel, :address_1, :address_2, :school, :school_class, :parental_agreement, :medical_info, :team_id)
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
