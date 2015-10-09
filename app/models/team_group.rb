class TeamGroup < ActiveRecord::Base
  belongs_to :team
  has_many :users

  def user_full_names
    tabs = []
    users.each do |u|
      tabs << u.full_name
    end
    tabs.join(', ')
  end

end
