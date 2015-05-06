class CreateBadgesToTrials < ActiveRecord::Migration
  def change
    create_table :badges_to_trials do |t|
      t.references :badge, index: true
      t.references :trial, index: true
    end
  end
end
