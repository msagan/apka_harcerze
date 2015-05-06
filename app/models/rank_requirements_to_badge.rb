class RankRequirementsToBadge < ActiveRecord::Base
  belongs_to :badge
  belongs_to :rank_requirement
end
