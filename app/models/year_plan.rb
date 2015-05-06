class YearPlan < ActiveRecord::Base
  belongs_to :team
  has_many :cycles
  has_and_belongs_to_many :badges
end
