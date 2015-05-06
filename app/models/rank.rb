require 'csv'
require "open-uri"
class Rank < ActiveRecord::Base
  has_many :rank_requirements, dependent: :destroy
  belongs_to :trial

  def self.get_from_file!
    @file = File.open("#{Rails.root.to_s}/lib/files/ranks.csv")
    content = @file.read
    content.gsub! "\r\n", 'nowalinia'
    content.gsub! "\n", 'linia'
    content.gsub! "\r", 'linia'
    content.gsub! "'", ""
    ranks = CSV.parse(content, col_sep: ';', headers: true, return_headers: false, converters: :numeric, row_sep: 'nowalinia',encoding: 'utf-8')
    ranks.each_with_index do |rank, i|
      puts i + 1
      r = Rank.new(level: i + 1)
      rank.each do |color|
        puts color[0]
        requirements = color[1].split 'linia'
        requirements.each_with_index do |requirement, j|
          unless requirement.include? '*'
            puts "#{j+1} #{color[0]} #{requirement}"
            r.rank_requirements << RankRequirement.new(color: I18n.t('colors.'+color[0].downcase).to_sym, description: requirement)
          end
        end
      end
      r.save!
    end
  end

  def self.build_rank(level)
    @file = File.open("#{Rails.root.to_s}/lib/files/ranks.csv")
    content = @file.read
    content.gsub! "\r\n", 'nowalinia'
    content.gsub! "\n", 'linia'
    content.gsub! "\r", 'linia'
    content.gsub! "'", ""
    ranks = CSV.parse(content, col_sep: ';', headers: true, return_headers: false, converters: :numeric, row_sep: 'nowalinia',encoding: 'utf-8')
    r = Rank.new(level: level)
    ranks[level-1].each do |color|
      puts color[0]
      requirements = color[1].split 'linia'
      requirements.each_with_index do |requirement, j|
        unless requirement.include? '*'
          puts "#{j+1} #{color[0]} #{requirement}"
          r.rank_requirements << RankRequirement.new(color: I18n.t('colors.'+color[0].downcase).to_sym, description: requirement)
        end
      end
    end
    r.save
    r
  end

  def badge_ids
    badges = []
    self.rank_requirements.each do |rr|
      puts rr.badge_ids
      badges.push(rr.badge_ids)
    end
    badges.flatten!
  end
end
