class AddShawlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :shawl, :boolean
  end
end
