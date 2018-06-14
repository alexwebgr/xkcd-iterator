  # Preview all emails at http://localhost:3000/rails/mailers/activate_subscription_mailer
class ActivateSubscriptionMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/activate_subscription_mailer/do_send
  def do_send
    ActivateSubscriptionMailer.do_send('')
  end
end
