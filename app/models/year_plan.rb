class YearPlan < ActiveRecord::Base
  belongs_to :team
  has_many :cycles
  has_and_belongs_to_many :badges
  validates :title, presence: true

  def plan_badges
    plan_badges = self.badges.group_by(&:color)
    plan_badges.each do |badge|
      badge[1].map!{ |b| [b, b.team_trial_count(self.team)] }
      badge[1].sort_by{ |b| b.reverse }
    end
    plan_badges.each do |arr|
      arr[1].sort! {|a,b| b[1] <=> a[1]}
    end
  end

end
