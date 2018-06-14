require 'test_helper'

class Admin::ImporterControllerTest < ActionDispatch::IntegrationTest
  test "should get comics" do
    get admin_importer_comics_url
    assert_response :success
  end

end
