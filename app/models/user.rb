class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  extend Enumerize
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
   attr_accessor :locked_at, :last_locked_at
   
   enumerize :role, in: [:client, :staff, :admin], default: :client, scope: true, predicates: true
      
   def lock_access!(notify=true)
     UserMailer.account_locked(self).deliver if notify
     self.locked_at = Time.now  
     self.last_locked_at = Time.now    
     true
   end      
end
