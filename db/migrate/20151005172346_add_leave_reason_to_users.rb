class AddLeaveReasonToUsers < ActiveRecord::Migration
  def change
    add_column :users, :leave_reason, :string
  end
end
