class Team < ActiveRecord::Base
  has_many :scouts, class_name: "User"
  belongs_to :user, class_name: "User"
  has_many :cycles
  has_many :year_plans
  has_many :team_groups
  validate :name, :base, :chapter, :banner, :ceremonial, :date_of_creation

  def get_team_badges
    Badge.where(id: self.scouts.includes(trials: :badges_to_trials).pluck(:'badges_to_trials.badge_id') )
  end
end
