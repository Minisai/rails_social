class UserMailer < ActionMailer::Base
  default :from => "railsminisai@gmail.com"

  def friend_email(user, friend)
    @user = user
    @friend = friend
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end

end