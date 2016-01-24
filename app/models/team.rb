class Team < ActiveRecord::Base
  has_many :scouts, class_name: "User"
  belongs_to :user, class_name: "User"
  has_many :cycles
  has_many :year_plans
  has_many :team_groups
  validate :name, :base, :chapter, :banner, :ceremonial, :date_of_creation

  def get_team_badges
    # badges = Badge.where(id: self.scouts.includes(trials: :badges_to_trials).pluck(:'badges_to_trials.badge_id') ).map{ |b| [b, b.team_trial_count(self)] }
    badges = Badge.where(id: self.scouts.includes(trials: :badges_to_trials).pluck(:'badges_to_trials.badge_id') ).group_by(&:color)
    badges.each do |badge|
      badge[1].map!{ |b| [b, b.team_trial_count(self)] }
      badge[1].sort_by{ |b| b.reverse }
    end
    badges.each do |arr|
      arr[1].sort! {|a,b| b[1] <=> a[1]}
    end
  end
end
