class RemoveUserIdFromPlanPoints < ActiveRecord::Migration
  def change
    remove_reference :plan_points, :user, index: true
  end
end
