class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  
  validates :user_id,  presence: true
  validates :content, length: { :minimum => 0, :maximum => 140 },
                                  presence: true
                                                       

  
  # Returns microposts from the users being followed by the given user.
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end

