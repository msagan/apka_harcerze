class CreateCustomTasksRankRequirements < ActiveRecord::Migration
  def change
    create_table :custom_tasks_rank_requirements do |t|
      t.belongs_to :rank_requirement, index: true
      t.belongs_to :custom_task, index: true
    end
  end
end
