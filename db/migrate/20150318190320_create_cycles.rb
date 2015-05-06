class CreateCycles < ActiveRecord::Migration
  def change
    create_table :cycles do |t|
      t.string :name
      t.references :team, index: true
      t.datetime :start_date
      t.datetime :stop_date

      t.timestamps
    end
  end
end
