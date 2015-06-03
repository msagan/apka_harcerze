class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :team, class_name: "Team"
  has_many :lead_teams, class_name: "Team"
  has_many :badge_trials
  has_many :badges, through: :badge_trials, source: :badge
  has_many :trials
  has_and_belongs_to_many :meetings
  has_and_belongs_to_many :badge_requirements
  has_many :custom_tasks
  
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

  def full_name
    first_name + " " + last_name
  end

  def is_done_with_trial?
    # (self.trials.last.badge_ids - self.badge_ids).empty?
    (self.trials.last.badge_ids - self.badge_ids).empty? && (self.trials.last.custom_tasks - self.custom_tasks).empty?
  end

  def attended_meetings
    @meetings = Meeting.all.select { |m| m.user_ids.include? id }
  end

end
