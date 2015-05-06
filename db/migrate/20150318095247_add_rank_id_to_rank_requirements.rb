class AddRankIdToRankRequirements < ActiveRecord::Migration
  def change
    add_reference :rank_requirements, :rank, index: true
  end
end
