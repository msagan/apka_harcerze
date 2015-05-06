class AddCompletedToTrial < ActiveRecord::Migration
  def change
    add_column :trials, :completed, :boolean, default: false
  end
end
