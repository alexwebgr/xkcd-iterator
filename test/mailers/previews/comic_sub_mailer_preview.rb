# Preview all emails at http://localhost:3000/rails/mailers/comic_sub_mailer
class ComicSubMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/comic_sub_mailer/do_send
  def do_send
    ComicSubMailer.do_send
  end

end
