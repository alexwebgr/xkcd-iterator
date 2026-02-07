class ComicSubMailer < ApplicationMailer
  def do_send(subscriber, comic)
    @subscriber = subscriber
    @comic = comic

    html_body = ApplicationController.render(
      template: 'comic_sub_mailer/do_send',
      layout: 'mailer',
      assigns: { subscriber: @subscriber, comic: @comic }
    )

    Resend::Emails.send({
      from: 'onboarding@resend.dev', # Use your verified domain
      to: [subscriber.email],
      subject: "XKCD ##{comic.num}",
      html: html_body
    })
  end
end
