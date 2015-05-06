class BadgeRequirement < ActiveRecord::Base
  belongs_to :badge
  has_many :plan_points, as: :set
end
