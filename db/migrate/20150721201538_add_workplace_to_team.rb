class AddWorkplaceToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :base, :string
    add_column :teams, :adjutant_1, :string
    add_column :teams, :adjutant_2, :string
    add_column :teams, :banner, :string
    add_column :teams, :chapter, :string
    add_column :teams, :date_of_creation, :date
    add_column :teams, :ceremonial, :text
  end
end
