class UserMailer < ApplicationMailer
  default from: "onanez45@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://dealers.com/login'
    mail(:to => @user.email, :subject => 'Welcome to Dealers')
  end
end
