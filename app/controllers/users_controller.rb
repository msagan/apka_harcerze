# coding: UTF-8

class UsersController < ApplicationController
  before_action :authenticate_user!


  def archive
    @user = User.find(params[:id])
    @user.archive!
    redirect_to team_path(@user.team), notice: 'Zuch przeniesiony do archiwum.'
  end

  def show_trial
    @user = User.find(params[:id])
  end

  def edit_trial
    @colors = ['czerwony', 'zolty', 'zielony', 'fioletowy', 'niebieski']
    @trial = Trial.find(params[:id])
    @badges = Badge.all
  end

  def update_trial
    @trial = Trial.find(params[:id])
    @trial.update(trial_params)
    redirect_to manage_trial_path(@trial)
  end

  def finish_trial
    @trial = Trial.find(params[:id])
    user = @trial.user
    if user.scouts_mark?
      user.update(stars: user.stars + 1)
      @trial.update(completed: true)
      redirect_to team_path(@trial.user.team), notice: 'Zakończono próbę!'
    else
      redirect_to team_path(trial.user.team), alert: 'Nie można przyznać gwiazdki zuchowi bez znaczka!'
    end
  end

  def edit_scout
    @user = User.find(params[:id])
  end

  def update_scout
    @user = User.find(params[:id])
    @user.update(user_params)
  end

  def show_trial
    @trial = Trial.find(params[:id])
    @user = @trial.user
  end

  def manage_trial
    @trial = Trial.find(params[:id])
    @user = @trial.user
  end

  def progress_trial
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to manage_trial_path(@user.trials.last)
  end

  def start_trial
    @user = User.find(params[:id])
    t = Trial.new(rank: Rank.build_rank(@user.stars+1))
    @user.trials << t
    @user.save
    redirect_to edit_trial_path(t.id)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :scouts_mark, :date_of_admission, :date_of_leave, :phone_number, :parent_1, :parent_2, :parent_1_phone, :parent_1_email, :parent_2_email, :parent_2_phone, :team_group_id, :birth_date, badge_ids: [], custom_task_ids: [])
  end

  def trial_params
    params.require(:trial).permit(:rank, :badges, custom_tasks_attributes: [:id, :name, :description, :_destroy], badge_ids: [])
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
