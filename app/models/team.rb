class Team < ActiveRecord::Base
  has_many :scouts, class_name: "User"
  belongs_to :user, class_name: "User"
  has_many :cycles
  has_many :year_plans

  validate :name, :base, :chapter, :banner, :ceremonial, :date_of_creation


end
