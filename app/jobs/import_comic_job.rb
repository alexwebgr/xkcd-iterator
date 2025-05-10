class ImportComicJob < ApplicationJob
  queue_as :default

  def perform(index)
    uri = URI("https://xkcd.com/#{index}/info.0.json")

    res = Net::HTTP.get_response(uri)
    body = JSON.parse(res.body, {symbolize_names: true})

    sleep 2
    width, height = FastImage.size(body[:img])

    Comic.create!(
      num: body[:num],
      title: body[:title],
      safe_title: body[:safe_title],
      img_url: body[:img],
      alt_text: body[:alt],
      day: body[:day],
      month: body[:month],
      year: body[:year],
      transcript: body[:transcript],
      width: width,
      height: height
    )
  end
end
