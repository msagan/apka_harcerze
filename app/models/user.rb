class User < ActiveRecord::Base
  include ActiveModel::Validations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  belongs_to :team, class_name: "Team"
  has_many :lead_teams, class_name: "Team"
  has_many :badge_trials
  has_many :badges, through: :badge_trials, source: :badge
  has_many :trials
  has_and_belongs_to_many :meetings
  has_and_belongs_to_many :badge_requirements
  has_many :custom_tasks
  belongs_to :team_group
  attr_accessor :signing_in
  validates_with UserValidator
  validate :parent_1_phone, :parent_1, :parent_2, :school_class, :pesel, :stars, :first_name, :last_name, presence: true, if: :should_validate
  validate :stars, numericality: { greater_than_or_equal_to: 0, lesser_than_or_equal_to: 3 }

  REASONS_OF_LEAVE= ['Inne', 'Przejście do drużyny', 'Rezygnacja z zuchów', 'Za mało czasu']

  scope :inactive, -> { where(archived: true) }
  scope :active, -> { where(archived: false) }

  def archive!
    self.archived = true
    self.date_of_leave = DateTime.now
    self.save
  end

  def unarchive!
    self.archived = false
    self.date_of_leave = nil
    self.leave_reason = nil
    self.save
  end

  def set_archived_false
    self.archived=false
  end

  def badges_names
    self.badges.pluck(:name)
  end

  def has_badge?(badge)
    self.badges.include? badge
  end

  def has_task?(task)
    self.custom_tasks.include? task
  end

  def has_incomplete_trials?
    self.trials.incomplete.count > 0 && self.trials.count > 0
  end

  def team_group_name
    team_group.present? ? team_group.name : ' '
  end

  def incomplete_badges
    hash = {}
    self.badge_requirements.each do |br|
      if hash[br.badge].present?
        hash[br.badge] += 1
      else
        hash[br.badge] = 1
      end
    end
    hash
  end

  def should_validate
    self.signing_in
  end

  def shouldnt_validate
    !self.signing_in
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def is_done_with_trial?
    # (self.trials.last.badge_ids - self.badge_ids).empty?
    (self.trials.incomplete.last.badge_ids - self.badge_ids).empty? && (self.trials.incomplete.last.custom_tasks - self.custom_tasks).empty?
  end

  def completed_badges_from_trial_count(trial_id)
    trial = Trial.find(trial_id)
    badge_ids = trial.badge_ids
    self.badges.where(id: badge_ids).count
  end

  def completed_tasks_from_trial_count(trial_id)
    self.custom_tasks.where(trial_id: trial_id).count
  end

  def attended_meetings
    @meetings = Meeting.all.select { |m| m.user_ids.include? id }
  end

end
