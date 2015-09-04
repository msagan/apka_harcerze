class CustomTask < ActiveRecord::Base
  has_many :plan_points, as: :set
  belongs_to :user
  belongs_to :trial

  validates :name, :description, presence: true

end
