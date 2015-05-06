class CreateTrials < ActiveRecord::Migration
  def change
    create_table :trials do |t|
      t.references :user, index: true

      t.timestamps
    end
  end
end
