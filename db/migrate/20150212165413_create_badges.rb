class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.integer :color
      t.string :name
      t.text :description
      t.text :comment

      t.timestamps
    end
  end
end
