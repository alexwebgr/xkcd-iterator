class SendComicJob < ApplicationJob
  queue_as :default

  def perform(subscriber_id)
    subscriber = Subscriber.verified.find_by(id: subscriber_id)

    return if subscriber.nil?

    email_receipt = subscriber.email_receipts.order(num: :desc).first

    if email_receipt.present?
      comic = last_comic(email_receipt.comic)
    else
      comic = Comic.order(num: :asc).first
    end

    # do_send bypasses ActionMailer's `mail(...)` DSL and sends via the Resend API directly,
    # so deliver_now's return value isn't meaningful here (it's always nil). Success is
    # "didn't raise" - a Resend failure propagates up and skips the receipt below.
    ComicSubMailer.do_send(subscriber, comic).deliver_now

    EmailReceipt.create({
      subscriber_id: subscriber.id,
      comic_id: comic.id,
      num: comic.num,
      subscription: Subscription.where(subs_name: 'comic_sub').where(subscriber_id: subscriber.id).first
    })
  end

  def last_comic(comic)
    if Comic.by_num(comic.num + 1).present?
      Comic.by_num(comic.num + 1)
    else
      Comic.by_num Comic.last_num
    end
  end
end
