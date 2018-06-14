class Subscription < ApplicationRecord
  belongs_to :subscriber

  validates :subs_name, presence: true
  validates :subscriber_id, presence: true

  def self.add_comic_sub(subscriber_id)
    subs_name = 'comic_sub'

    sub = Subscription
      .where(subs_name: subs_name)
      .where(subscriber_id: subscriber_id)

    if sub.exists?
      sub.update(active: true)
    else
      sub.create(subs_name: subs_name, label: 'Comic subscription', active: true, subscriber_id: subscriber_id)
    end
  end

  def self.remove_comic_sub(subscriber_id)
    subs_name = 'comic_sub'

    sub = Subscription
      .where(subs_name: subs_name)
      .where(subscriber_id: subscriber_id)

    if sub.exists?
      sub.update(active: false)
    end
  end

  def self.send_mail(subscribers)
    subscribers.each do |subscriber|
      email_receipt = subscriber.email_receipts.order(num: 'DESC').first

      if email_receipt.present?
        comic_w = email_receipt.comic
        comic = Comic.by_num(comic_w.num + 1).present? ? Comic.by_num(comic_w.num + 1) : Comic.by_num(Comic.last_num)
      else
        comic = Comic.first
      end

      if ComicSubMailer.do_send(subscriber, comic).deliver_now
        EmailReceipt.find_or_create_by!({
                                          subscriber_id: subscriber.id,
                                          comic_id: comic.id,
                                          num: comic.num,
                                          subscription: Subscription.where(subs_name: 'comic_sub').where(subscriber_id: subscriber.id).first
                                        })
      end
    end
  end

  def self.send_comic
    subscriber_ids = Subscription
                         .where(subs_name: 'comic_sub')
                         .where(active: true)
                         .pluck('subscriber_id')

    self.send_mail(Subscriber.find(subscriber_ids))
  end
end
