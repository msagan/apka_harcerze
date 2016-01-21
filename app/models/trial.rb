class Trial < ActiveRecord::Base
  belongs_to :user
  has_one :rank
  has_many :custom_tasks
  has_many :rank_requirements
  has_many :badges_to_trials
  has_many :badges, through: :badges_to_trials
  accepts_nested_attributes_for :custom_tasks, reject_if: :all_blank, allow_destroy: true
  scope :incomplete, -> { where(completed: false) }

  def completion_percentage
    completed_badges = self.user.completed_badges_from_trial_count(self.id)
    completed_tasks = self.user.completed_tasks_from_trial_count(self.id)
    if self.task_count == 0
      0
    else
      ( ( (completed_badges + completed_tasks).to_f / (self.task_count).to_f ) * 100 ).to_i
    end
  end

  def task_count
    self.badges.count + self.custom_tasks.count
  end

end
