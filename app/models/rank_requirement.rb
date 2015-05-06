class RankRequirement < ActiveRecord::Base
  belongs_to :rank
  has_many :rank_requirements_to_badges
  has_many :badges, through: :rank_requirements_to_badges
  enum color: { red: 0, yellow: 1, purple: 2, blue: 3, green: 4 }
end
