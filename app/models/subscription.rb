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

  def self.send_comic
    subscriber_ids = Subscription
                         .where(subs_name: 'comic_sub')
                         .where(active: true)
                         .pluck('subscriber_id')

    failures = []

    subscriber_ids.each do |subscriber_id|
      begin
        SendComicJob.perform_now(subscriber_id)
      rescue => e
        failures << subscriber_id
        Rails.logger.error("[Subscription.send_comic] failed to send comic to subscriber ##{subscriber_id}: #{e.class}: #{e.message}\n#{e.backtrace&.first(10)&.join("\n")}")
      end
    end

    failures
  end
end
