class Comic < ApplicationRecord
  validates :num, presence: true, uniqueness: true
  validates :title, presence: true
  validates :safe_title, presence: true
  validates :img_url, presence: true

  def self.latest
    latest_uri = URI("https://xkcd.com/info.0.json")

    latest_res = Net::HTTP.get_response(latest_uri)
    JSON.parse(latest_res.body, {symbolize_names: true})
  end

  def self.update_tree
    from = Comic.last_num == 1 ? Comic.last_num : Comic.last_num + 1
    to = self.latest[:num]

    self.do_import(from, to)
  end

  def self.do_import(from, to)
    (from..to).each {|i|
      uri = URI("https://xkcd.com/#{i}/info.0.json")

      res = Net::HTTP.get_response(uri)
      body = JSON.parse(res.body, {symbolize_names: true})

      Comic.create!(
        num: body[:num],
        title: body[:title],
        safe_title: body[:safe_title],
        img_url: body[:img],
        alt_text: body[:alt],
        day: body[:day],
        month: body[:month],
        year: body[:year],
        transcript: body[:transcript]
      )
    }
  rescue StandardError => e
    Rails.logger.error e
  end

  def self.last_num
    comic = Comic.order(num: :desc).first
    comic.present? ? comic.num : 1
  end

  def self.by_num(comic_num)
    Comic.find_by_num(comic_num)
  end
end
