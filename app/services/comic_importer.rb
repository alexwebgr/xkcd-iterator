# frozen_string_literal: true

class ComicImporter
  def self.call
    new.call
  end

  def call
    last_num = Comic.last_num
    from = last_num == 1 ? last_num : last_num + 1
    to = latest[:num]

    import(from, to)
  end

  def import(from, to)
    range = (from..to)
    comics = Comic.where(num: range).pluck(:num)

    (range.to_a - comics).each {|i| ImportComicJob.perform_later(i) }
  end

  def latest
    latest_uri = URI("https://xkcd.com/info.0.json")

    latest_res = Net::HTTP.get_response(latest_uri)
    JSON.parse(latest_res.body, {symbolize_names: true})
  end
end
