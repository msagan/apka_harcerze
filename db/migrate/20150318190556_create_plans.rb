class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.references :meeting, index: true

      t.timestamps
    end
  end
end
