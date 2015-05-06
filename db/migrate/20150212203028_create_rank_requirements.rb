class CreateRankRequirements < ActiveRecord::Migration
  def change
    create_table :rank_requirements do |t|
      t.integer :color
      t.text :description
      t.references :trial, index: true

      t.timestamps
    end
  end
end
