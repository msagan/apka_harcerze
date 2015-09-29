class AddTeamGroupIdToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :team_group, index: true
  end
end
