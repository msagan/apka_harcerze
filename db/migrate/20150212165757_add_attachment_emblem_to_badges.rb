class AddAttachmentEmblemToBadges < ActiveRecord::Migration
  def self.up
    change_table :badges do |t|
      t.attachment :emblem
    end
  end

  def self.down
    remove_attachment :badges, :emblem
  end
end
