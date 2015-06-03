class CreateMeetingsUsers < ActiveRecord::Migration
  def change
    create_table :meetings_users do |t|
      t.belongs_to :meeting, index: true
      t.belongs_to :user, index: true
    end
  end
end
