class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :User, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :stars, :integer, default: 0
    add_column :users, :description, :text
    add_column :users, :pesel, :integer
    add_column :users, :address_1, :string
    add_column :users, :address_2, :string
    add_column :users, :school, :string
    add_column :users, :school_class, :string
    add_column :users, :parental_agreement, :boolean
    add_column :users, :medical_info, :text
    add_reference :users, :team, index: true
  end
end
