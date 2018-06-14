require 'test_helper'

class IteratorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get iterator_index_url
    assert_response :success
  end

  test "should get show" do
    get iterator_show_url
    assert_response :success
  end

end
