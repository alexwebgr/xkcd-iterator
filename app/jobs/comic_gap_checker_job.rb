class ComicGapCheckerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    available_comic_nums = Comic.order(num: :asc).pluck(:num)
    gaps = find_gaps_in_comics(available_comic_nums)

    if gaps.any?
      if gaps.length > 5
        raise RuntimeError, "Found #{gaps} gaps found in comic numbering sequence."
      end

      gaps.each { |missing_num| ImportComicJob.perform_later(missing_num) }
    else
      p "No gaps found in comic numbering sequence."
    end
  end

  private

  def find_gaps_in_comics(comic_nums)
    return [] if comic_nums.empty? || comic_nums.length < 3

    gaps = []

    comic_nums.each_with_index do |num, i|
      next if i == 0
      prev_num = comic_nums[i - 1]

      if num - prev_num > 1
        (prev_num + 1...num).each { |missing| gaps << missing }
      end
    end

    gaps
  end
end
