module ApplicationHelper
  def navigate_previous_comic(comic_id)
    id = (comic_id || 1).to_i - 1
    id = 1 if id < 1

    iterator_show_url(id)
  end

  def navigate_random_comic
    id = rand(Comic.last_num)
    id = 1 if id == 0

    iterator_show_url(id)
  end

  def navigate_next_comic(comic_num)
    last = Comic.last_num
    id = (comic_num.to_i || last) + 1
    id = last if id > last

    iterator_show_url(id)
  end

  def navigate_xkcd(id)
    "http://xkcd.com/#{id}"
  end

  def favorited(comic_num)
    comic = Comic.by_num(comic_num)
    Favorite
      .where(subscriber_id: current_subscriber)
      .where(comic_id: comic)
  end
end
