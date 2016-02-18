# coding: UTF-8

class UsersController < ApplicationController
  before_action :authenticate_user!

  layout 'application', :except => :show_trial

  def archive
    @user = User.find(params[:id])
  end

  def finish_archiving
    @user = User.find(params[:id])
    @user.leave_reason = params[:additional_leave_info].present? ? user_params[:leave_reason] + ' ' + params[:additional_leave_info] : user_params[:leave_reason]
    @user.archive!
    redirect_to team_path(@user.team), notice: 'Zuch przeniesiony do archiwum.'
  end

  def unarchive
    @user = User.find(params[:id])
    @user.unarchive!
    redirect_to team_path(@user.team), notice: 'Zuch przywrócony!'
  end


  def show_trial
    @trial = Trial.find(params[:id])
    @user = @trial.user
    @rank_requirements = @trial.rank_requirements_by_color
    respond_to do |format|
      format.html
      format.pdf { render pdf: "PDF_proba_#{@user.full_name}_#{@user.stars+1}_gwiazdka" }
    end
  end

  def edit_trial
    @colors = ['czerwony', 'zolty', 'zielony', 'fioletowy', 'niebieski']
    @trial = Trial.find(params[:id])
    @badges = Badge.badges_by_color
    add_breadcrumb "Drużyny", :teams_path
    add_breadcrumb "Lista zuchów", team_path(@trial.user.team)
    add_breadcrumb "Próba na gwiazdkę"
  end

  def update_trial
    @trial = Trial.find(params[:id])
    @trial.custom_tasks.each do |ct|
      ct.rank_requirement_ids = []
    end
    @trial.update(trial_params)
    redirect_to edit_trial_path(@trial)
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


  def edit_trial_requirements
    @trial = Trial.find(params[:id])
    @user = @trial.user
    add_breadcrumb "Drużyny", :teams_path
    add_breadcrumb "Lista zuchów", teams_path(@user.team)
  end

  def manage_trial
    @trial = Trial.find(params[:id])
    @user = @trial.user
    add_breadcrumb "Drużyny", :teams_path
    add_breadcrumb "Lista zuchów", team_path(@trial.user.team)
    add_breadcrumb "Próba na gwiazdkę"
    respond_to do |format|
      format.html
      format.pdf { render :pdf => "Zarzadzaj_#{@user.full_name}_#{@user.stars+1}_gwiazdka" }
    end
  end

  def progress_trial
    @user = User.find(params[:id])
    @user.update(user_params)
    if params[:user][:removed_badge_ids].present?
      @user.badge_ids = @user.badge_ids.reject{ |e| params[:user][:removed_badge_ids].map(&:to_i).include? e }
    end
    if params[:user][:removed_custom_task_ids].present?
      @user.custom_task_ids = @user.custom_task_ids.reject{ |e| params[:user][:removed_custom_task_ids].map(&:to_i).include? e }
    end
    @user.save
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
    params.require(:user).permit(:first_name, :last_name, :description, :scouts_mark, :date_of_admission, :date_of_leave, :phone_number, :parent_1, :parent_2, :parent_1_phone, :parent_1_email, :parent_2_email, :parent_2_phone, :team_group_id, :birth_date, :leave_reason, :additional_leave_info, badge_ids: [], custom_task_ids: [])
  end

  def trial_params
    params.require(:trial).permit(:rank, :badges, custom_tasks_attributes: [:id, :name, :description, :_destroy, rank_requirement_ids:[]], badge_ids: [])
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
