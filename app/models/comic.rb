class Comic < ApplicationRecord
  validates :num, presence: true, uniqueness: true
  validates :title, presence: true
  validates :safe_title, presence: true
  validates :img_url, presence: true

  def self.last_num
    comic = Comic.order(num: :desc).first
    comic.present? ? comic.num : 1
  end

  def self.by_num(comic_num)
    find_by_num(comic_num)
  end
end
