class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.text :history
      t.text :situation_description

      t.timestamps
    end
  end
end
