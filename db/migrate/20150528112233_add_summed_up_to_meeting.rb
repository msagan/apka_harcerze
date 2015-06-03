class AddSummedUpToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :summed_up, :boolean
  end
end
