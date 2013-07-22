class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  
  validates :user_id,  presence: true
  validates :content, length: { :minimum => 0, :maximum => 140 },
                                  presence: true
                                                       

end
