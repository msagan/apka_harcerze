class CreateCustomTasks < ActiveRecord::Migration
  def change
    create_table :custom_tasks do |t|
      t.string :name
      t.text :description
      t.references :trial, index: true
      t.timestamps
    end
  end
end
