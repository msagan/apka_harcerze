require 'csv'
require "open-uri"
class Badge < ActiveRecord::Base
  has_many :users, through: :badge_trials, source: :user
  has_attached_file :emblem, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :emblem, :content_type => /\Aimage\/.*\Z/
  enum color: { red: 0, yellow: 1, purple: 2, blue: 3, green: 4 }
  has_many :badge_requirements, dependent: :destroy
  has_many :badges_to_trials
  has_many :badge_trials
  has_many :trials, through: :badges_to_trials
  has_many :rank_requirements_to_badges
  has_many :rank_requirements, through: :rank_requirements_to_badges
  has_and_belongs_to_many :custom_tasks
  has_and_belongs_to_many :year_plans
  has_and_belongs_to_many :cycles
  scope :colored, ->(color) { where(:color => color)}

  def self.get_from_file!
    @file = File.open("#{Rails.root.to_s}/lib/files/badges.csv")
    content = @file.read
    content.gsub! "\r\n", 'nowalinia'
    content.gsub! "\n", 'linia'
    content.gsub! "\r", 'linia'
    content.gsub! '"', "''"
    badges = CSV.parse(content, col_sep: ';', headers: true, return_headers: false, converters: :numeric, row_sep: 'nowalinia',encoding: 'utf-8')
    puts badges.count
    badges.each_with_index do |badge,index|
      b = Badge.new(color: I18n.t('colors.'+badge[1].downcase).to_sym, name: badge[2], description: badge[3], comment: badge[5])
      requirements = badge[4]
      requirements.split('linia').each do |r|
        b.badge_requirements << BadgeRequirement.new(description: r.gsub("'", ""))
      end
      puts b.name
      b.emblem = open("#{Rails.root.to_s}/lib/files/badge_emblems/" + I18n.transliterate(b.name).downcase.gsub(" ", "_") + '.png')
      b.save
    end
  end

  def self.badges_by_color
    Badge.all.group_by(&:color)
  end

  def requirement_count
    self.badge_requirements.size
  end

  def requirement_names
    self.badge_requirements.pluck(:description).sort
  end

  def requirements_select
    self.badge_requirements.collect{|b| [b.id, b.description]}
  end

  def team_trial_count(team)
    self.badges_to_trials.joins(trial: :user).where(trials: {user_id: team.scout_ids}).count
  end

  #TODO do przepisania, za długo

end
