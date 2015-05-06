class Trial < ActiveRecord::Base
  belongs_to :user
  has_one :rank
  has_many :custom_tasks
  has_many :rank_requirements
  has_many :badges_to_trials
  has_many :badges, through: :badges_to_trials
  accepts_nested_attributes_for :custom_tasks, reject_if: :all_blank, allow_destroy: true
  scope :incomplete, -> { where(completed: false) }
end
