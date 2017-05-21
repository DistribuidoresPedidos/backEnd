class UserMailer < ApplicationMailer
  default from: 'onanez45@gmail.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://www.google.com.co/'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def order_confirmation(user)
    @user = user
    mail(to: @user.email, subject: 'Tu pedido ha sido realizado')
  end
end
