class AddTrialIdToRank < ActiveRecord::Migration
  def change
    add_reference :ranks, :trial, index: true
  end
end
