class UserMailer < ApplicationMailer
  default from: 'ofnanezn@gmail.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Bienvenido a Dealers!')
  end
end
