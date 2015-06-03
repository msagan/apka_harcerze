class CreateBadgeRequirementsUsers < ActiveRecord::Migration
  def change
    create_table :badge_requirements_users do |t|
      t.belongs_to :badge_requirement, index: true
      t.belongs_to :user, index: true
    end
  end
end
