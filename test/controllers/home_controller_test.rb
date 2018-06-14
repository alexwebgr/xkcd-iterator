require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "should get who" do
    get home_who_url
    assert_response :success
  end

  test "should get contact_us" do
    get home_contact_us_url
    assert_response :success
  end

end
