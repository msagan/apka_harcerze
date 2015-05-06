class Cycle < ActiveRecord::Base
  belongs_to :team
  belongs_to :year_plan
  has_many :meetings
end
