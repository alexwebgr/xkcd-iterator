class ComicSubMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comic_sub_mailer.do_send.subject
  #
  def do_send(subscriber, comic)
    @subscriber = subscriber
    @comic = comic
    mail to: subscriber.email, subject: "XKCD ##{comic.num}"
  end
end
