require 'test_helper'

class LoginControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get login_show_url
    assert_response :success
  end

  test "should get google_auth" do
    get login_google_auth_url
    assert_response :success
  end

  test "should get destroy" do
    get login_destroy_url
    assert_response :success
  end

end
