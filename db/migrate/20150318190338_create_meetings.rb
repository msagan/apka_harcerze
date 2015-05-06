class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :stop_date
      t.references :cycle, index: true

      t.timestamps
    end
  end
end
