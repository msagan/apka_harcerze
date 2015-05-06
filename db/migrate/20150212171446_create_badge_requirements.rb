class CreateBadgeRequirements < ActiveRecord::Migration
  def change
    create_table :badge_requirements do |t|
      t.references :badge, index: true
      t.text :description
      
      t.timestamps
    end
  end
end
