class CreatePlanPointsUsers < ActiveRecord::Migration
  def change
    create_table :plan_points_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :plan_point, index: true
    end
  end
end
