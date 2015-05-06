class CreateBadgesYearPlans < ActiveRecord::Migration
  def change
    create_table :badges_year_plans do |t|
      t.belongs_to :badge, index: true
      t.belongs_to :year_plan, index: true
    end
  end
end
