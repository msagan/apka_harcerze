class AddUserReferenceToCustomTask < ActiveRecord::Migration
  def change
    add_reference :custom_tasks, :user, index: true
  end
end
