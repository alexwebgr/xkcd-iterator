class ActivateSubscriptionMailer < ApplicationMailer
  def do_send(subscriber)
    @subscriber = subscriber
    @ppr = BCrypt::Password.create(subscriber.email)

    mail to: subscriber.email, subject: 'Verify your email address at XKCD Iterator'
  end

  def do_send_magic_link(subscriber)
    @subscriber = subscriber
    @ppr = BCrypt::Password.create(subscriber.email)

    mail to: subscriber.email, subject: 'Login at XKCD Iterator'
  end
end
