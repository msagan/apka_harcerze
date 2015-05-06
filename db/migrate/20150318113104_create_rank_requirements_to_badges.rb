class CreateRankRequirementsToBadges < ActiveRecord::Migration
  def change
    create_table :rank_requirements_to_badges do |t|
      t.references :badge, index: true
      t.references :rank_requirement, index: true
    end
  end
end
