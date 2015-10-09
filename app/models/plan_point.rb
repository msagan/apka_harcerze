class PlanPoint < ActiveRecord::Base
  belongs_to :set, polymorphic: true
  belongs_to :badge_requirement
  has_and_belongs_to_many :badge_requirements
  validates :task_name, :task_time, :task_info, presence: true

  def badge_requirement_text
    if self.badge_requirement.present?
      self.badge_requirement.description
    else
      nil
    end
  end

end
