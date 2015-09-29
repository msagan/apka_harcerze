class CreateTeamGroups < ActiveRecord::Migration
  def change
    create_table :team_groups do |t|
      t.belongs_to :team, index: true
      t.string :name

      t.timestamps
    end
  end
end
