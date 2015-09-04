class CreateBadgesCycles < ActiveRecord::Migration
  def change
    create_table :badges_cycles do |t|
      t.belongs_to :badge, index: true
      t.belongs_to :cycle, index: true
    end
  end
end
