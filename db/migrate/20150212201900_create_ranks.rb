class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.integer :level

      t.timestamps
    end
  end
end
