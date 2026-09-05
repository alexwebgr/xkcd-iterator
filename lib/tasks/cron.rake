namespace :cron do
  desc "Send the daily comic to all active subscribers"
  task daily_newsletter: :environment do
    failures = Subscription.send_comic

    if failures.any?
      Rails.logger.error("[cron:daily_newsletter] #{failures.size} subscriber(s) failed: #{failures.inspect}")
      abort("cron:daily_newsletter completed with #{failures.size} failure(s)")
    else
      puts "cron:daily_newsletter completed successfully"
    end
  end

  desc "Import any missing comics from xkcd"
  task update_tree: :environment do
    failures = ComicImporter.call(inline: true)

    if failures.any?
      Rails.logger.error("[cron:update_tree] #{failures.size} comic(s) failed to import: #{failures.inspect}")
      abort("cron:update_tree completed with #{failures.size} failure(s)")
    else
      puts "cron:update_tree completed successfully"
    end
  end
end
