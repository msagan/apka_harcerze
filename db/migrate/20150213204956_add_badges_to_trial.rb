class AddBadgesToTrial < ActiveRecord::Migration
  def change
    add_reference :trials, :badge, index: true
  end
end
