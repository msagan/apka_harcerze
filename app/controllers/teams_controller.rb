# coding: UTF-8

class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :make_sure_team_is_mine, only: [:show]

  def index
    @teams = current_user.lead_teams
  end

  def show
    @users = current_user.lead_teams.find(params[:id]).scouts
    render :template => 'users/index'
  end

  def start_trial
    @user=User.find(params[:id])
    @user.trials << Trial.new(rank: Rank.find_by(level: @user.stars+1))
  end

  def team_params
    params.require(:team).permit(:name, :history, :situation_description)
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
