class AddParentEmailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :parent_1_email, :string
    add_column :users, :parent_2_email, :string
  end
end
