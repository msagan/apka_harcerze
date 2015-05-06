class CreateBadgeTrial < ActiveRecord::Migration
  def change
    create_table :badge_trials do |t|
      t.belongs_to :user, index: true
      t.belongs_to :badge, index: true
      t.timestamps null: false
    end
  end
end
