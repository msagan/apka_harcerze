class BadgesToTrial < ActiveRecord::Base
  belongs_to :badge
  belongs_to :trial
end
