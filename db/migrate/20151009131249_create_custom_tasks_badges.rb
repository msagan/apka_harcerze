class CreateCustomTasksBadges < ActiveRecord::Migration
  def change
    create_table :badges_custom_tasks do |t|
      t.belongs_to :badge
      t.belongs_to :custom_task, index: true
    end
  end
end
