class MeetingsController < ApplicationController
  before_action :authenticate_user!

  def show
    @meeting = Meeting.find(params[:id])
  end

  def sum_up
    @meeting = Meeting.find(params[:id])
    @scouts = @meeting.cycle.team.scouts
  end

  def new
    @cycle = Cycle.find(params[:id])
    @meeting = Meeting.new
  end

  def create
    @cycle = Cycle.find(params[:id])
    if @cycle.meetings << Meeting.create(meeting_params)
      redirect_to cycle_path(@cycle), notice: "Spotkanie dodane"
    else
      redirect_to cycle_path(@cycle)
    end
  end

  def edit
    @meeting = Meeting.find(params[:id])
  end

  def update
    @meeting = Meeting.find(params[:id])
    if @meeting.update(meeting_params)
      redirect_to cycle_path(@meeting.cycle), notice: "Spotkanie zmienione"
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
    params.require(:meeting).permit(:name, :start_date, :stop_date, user_ids: [], plan_point_ids: [])
  end


end