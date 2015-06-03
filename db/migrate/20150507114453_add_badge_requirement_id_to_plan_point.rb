class AddBadgeRequirementIdToPlanPoint < ActiveRecord::Migration
  def change
    add_reference :plan_points, :badge_requirement, index: true
  end
end
