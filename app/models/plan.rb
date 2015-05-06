class Plan < ActiveRecord::Base
  belongs_to :meeting
  has_many :plan_points, as: :set
  accepts_nested_attributes_for :plan_points, reject_if: :all_blank, allow_destroy: true
  
end
