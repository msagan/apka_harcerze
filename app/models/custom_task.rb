class CustomTask < ActiveRecord::Base
  has_many :plan_points, as: :set
  belongs_to :user
  belongs_to :trial
  has_and_belongs_to_many :rank_requirements
  validates :name, :description, presence: true

end
