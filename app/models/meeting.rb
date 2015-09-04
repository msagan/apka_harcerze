class Meeting < ActiveRecord::Base
  belongs_to :cycle
  has_one :plan
  has_and_belongs_to_many :users

  validates :name, :start_date, :stop_date, presence: true

end
