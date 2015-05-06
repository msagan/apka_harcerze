class Meeting < ActiveRecord::Base
  belongs_to :cycle
  has_one :plan
end
