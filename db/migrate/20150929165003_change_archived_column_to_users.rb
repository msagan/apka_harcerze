class ChangeArchivedColumnToUsers < ActiveRecord::Migration
  def change
    change_column :users, :archived, :boolean, defult: false
  end
end
