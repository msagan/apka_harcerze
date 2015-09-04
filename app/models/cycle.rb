class Cycle < ActiveRecord::Base
  belongs_to :team
  belongs_to :year_plan
  has_many :meetings
  has_and_belongs_to_many :badges
  validates :name, :start_date, :stop_date, presence: true


end
