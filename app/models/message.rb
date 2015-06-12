class Message < ActiveRecord::Base
  
  
  validates_presence_of :title, :text, :recipient
  
  belongs_to :recipient, :class_name => 'User'
  
end
