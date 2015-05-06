class PlanPoint < ActiveRecord::Base
  belongs_to :set, polymorphic: true
end
