class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :scouts_mark, :boolean
    add_column :users, :date_of_admission, :date
    add_column :users, :date_of_leave, :date
    add_column :users, :phone_number, :string
    add_column :users, :parent_1, :string
    add_column :users, :parent_2, :string
  end
end
