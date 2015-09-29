class RemovePhoneFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :phone_number, :integer
    add_column :users, :parent_1_phone, :integer
    add_column :users, :parent_2_phone, :integer
  end
end
