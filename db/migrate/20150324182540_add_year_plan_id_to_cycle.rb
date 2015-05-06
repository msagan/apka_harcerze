class AddYearPlanIdToCycle < ActiveRecord::Migration
  def change
    add_reference :cycles, :year_plan, index: true
  end
end
