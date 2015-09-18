# coding: UTF-8

class RankRequirementsController < ApplicationController
  before_action :authenticate_user!

  def update_badges
    p params
    rr = RankRequirement.find(params[:id])
    rr.rank.trial.badge_ids += rank_requirement_params[:badge_ids]
    rr.rank.save
    rr.update(rank_requirement_params)
    redirect_to :back
  end

  def rank_requirement_params
    params.require(:rank_requirement).permit(badge_ids: [] )
  end


end
