require 'test_helper'

class ComicSubMailerTest < ActionMailer::TestCase
  test "do_send" do
    mail = ComicSubMailer.do_send
    assert_equal "Do send", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
