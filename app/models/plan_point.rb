class PlanPoint < ActiveRecord::Base
  belongs_to :set, polymorphic: true
  belongs_to :badge_requirement
  has_and_belongs_to_many :badge_requirements
  has_and_belongs_to_many :users
  validates :task_name, :task_time, presence: true
  default_scope { order('created_at ASC') }
  def badge_requirement_text
    if self.badge_requirement.present?
      self.badge_requirement.description
    else
      nil
    end
  end

end
