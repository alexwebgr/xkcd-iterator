class ActivateSubscriptionMailer < ApplicationMailer
  def do_send(subscriber)
    @subscriber = subscriber
    @ppr = BCrypt::Password.create(subscriber.email)

    html_body = ApplicationController.render(
      template: 'activate_subscription_mailer/do_send',
      layout: 'mailer',
      assigns: { subscriber: @subscriber, ppr: @ppr }
    )

    Resend::Emails.send({
      from: 'onboarding@resend.dev',
      to: [subscriber.email],
      subject: "Verify your email address at XKCD Iterator",
      html: html_body
    })
  end

  def do_send_magic_link(subscriber)
    @subscriber = subscriber
    @ppr = BCrypt::Password.create(subscriber.email)

    html_body = ApplicationController.render(
      template: 'activate_subscription_mailer/do_send_magic_link',
      layout: 'mailer',
      assigns: { subscriber: @subscriber, ppr: @ppr }
    )

    Resend::Emails.send({
      from: 'onboarding@resend.dev',
      to: [subscriber.email],
      subject: "Login at XKCD Iterator",
      html: html_body
    })
  end
end
