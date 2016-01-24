class AddCeremonialToCycle < ActiveRecord::Migration
  def change
    add_column :cycles, :ceremonial, :text
  end
end
