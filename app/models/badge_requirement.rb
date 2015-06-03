class BadgeRequirement < ActiveRecord::Base
  belongs_to :badge
  has_many :plan_points
  has_and_belongs_to_many :users
end
