class CreatePlanPoints < ActiveRecord::Migration
  def change
    create_table :plan_points do |t|
      t.string :task_name
      t.integer :task_time
      t.text :task_info
      t.text :materials_needed
      t.string :person_responsible
      t.references :set, polymorphic: true, index: true

      t.timestamps
    end
  end
end
