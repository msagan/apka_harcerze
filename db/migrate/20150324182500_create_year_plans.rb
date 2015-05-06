class CreateYearPlans < ActiveRecord::Migration
  def change
    create_table :year_plans do |t|
      t.references :team, index: true
      t.string :title

      t.timestamps
    end
  end
end
