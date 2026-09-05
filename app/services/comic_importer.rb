# frozen_string_literal: true

class ComicImporter
  def self.call(inline: false)
    new.call(inline: inline)
  end

  def call(inline: false)
    last_num = Comic.last_num
    from = last_num == 1 ? last_num : last_num + 1
    to = latest[:num]

    import(from, to, inline: inline)
  end

  def import(from, to, inline: false)
    range = (from..to)
    comics = Comic.where(num: range).pluck(:num)
    failures = []

    (range.to_a - comics).each do |i|
      begin
        inline ? ImportComicJob.perform_now(i) : ImportComicJob.perform_later(i)
      rescue => e
        failures << i
        Rails.logger.error("[ComicImporter] failed to import comic ##{i}: #{e.class}: #{e.message}\n#{e.backtrace&.first(10)&.join("\n")}")
      end
    end

    failures
  end

  def latest
    latest_uri = URI("https://xkcd.com/info.0.json")

    latest_res = Net::HTTP.get_response(latest_uri)
    JSON.parse(latest_res.body, {symbolize_names: true})
  end
end
