class AddCommentaryToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :commentary, :text
  end
end
