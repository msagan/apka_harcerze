class MeetingsController < ApplicationController
  before_action :authenticate_user!

  def sum_up
    @meeting = Meeting.find(params[:id])
    @scouts = @meeting.cycle.year_plan.team.scouts
  end

  def show
    @meeting = Meeting.find(params[:id])
    @scouts = @meeting.cycle.year_plan.team.scouts
    respond_to do |format|
      format.pdf { render pdf: "PDF_meeting_#{@meeting.id}_#{@meeting.start_date}" }
    end
  end

  def new
    @cycle = Cycle.find(params[:id])
    @meeting = Meeting.new
    add_breadcrumb "Plany", :year_plans_path
    add_breadcrumb "Cykle", year_plan_path(@cycle.year_plan)
    add_breadcrumb 'Zbiórki', cycle_path(@cycle)
    add_breadcrumb 'Nowa zbiórka', new_meeting_path(@cycle)
  end

  def create
    @cycle = Cycle.find(params[:id])
    if @cycle.meetings << Meeting.create(meeting_params)
      redirect_to cycle_path(@cycle), notice: "Zbiórka dodana"
    else
      redirect_to cycle_path(@cycle)
    end
  end

  def edit
    @meeting = Meeting.find(params[:id])
    @cycle = @meeting.cycle
    add_breadcrumb "Plany", :year_plans_path
    add_breadcrumb "Cykle", year_plan_path(@cycle.year_plan)
    add_breadcrumb 'Zbiórki', cycle_path(@cycle)
    add_breadcrumb 'Edytuj zbiórkę', new_meeting_path(@cycle)
  end

  def update
    @meeting = Meeting.find(params[:id])
    if @meeting.update(meeting_params)
      redirect_to cycle_path(@meeting.cycle), notice: "Zbiórka zmieniona"
    else
      redirect_to cycle_path(@meeting.cycle)
    end
  end

  def destroy
    @meeting = Meeting.find(params[:id])
    @cycle = @meeting.cycle
    @meeting.destroy
    redirect_to cycle_path(@cycle)
  end

  def meeting_params
    params.require(:meeting).permit(:name, :start_date, :stop_date, :commentary, user_ids: [], plan_point_ids: [])
  end


end