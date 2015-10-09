class CreatePlanPointsToBadgeRequirements < ActiveRecord::Migration
  def change
    create_table :badge_requirements_plan_points do |t|
      t.belongs_to :badge_requirement, index: true
      t.belongs_to :plan_point, index: true
    end
  end
end
