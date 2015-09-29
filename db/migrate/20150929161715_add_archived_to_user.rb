class AddArchivedToUser < ActiveRecord::Migration
  def change
    add_column :users, :archived, :boolean
    change_column :users, :email, :string, unique: false, null: true
    
  end
end
