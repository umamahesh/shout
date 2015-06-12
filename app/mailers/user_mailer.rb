class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def account_locked(user)
    @user = user
    mail :to => @user.email, :subject => "Your account has been locked"
  end
  
end
