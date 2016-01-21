class AddSituationDescriptionToYearPlans < ActiveRecord::Migration
  def change
    add_column :year_plans, :situation_description, :text
  end
end
