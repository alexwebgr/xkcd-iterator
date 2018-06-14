require 'test_helper'

class EmailReceiptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @email_receipt = email_receipts(:one)
  end

  test "should get index" do
    get email_receipts_url
    assert_response :success
  end

  test "should get new" do
    get new_email_receipt_url
    assert_response :success
  end

  test "should create email_receipt" do
    assert_difference('EmailReceipt.count') do
      post email_receipts_url, params: { email_receipt: { comic_id: @email_receipt.comic_id, subscriber_id: @email_receipt.subscriber_id, subscription_id: @email_receipt.subscription_id } }
    end

    assert_redirected_to email_receipt_url(EmailReceipt.last)
  end

  test "should show email_receipt" do
    get email_receipt_url(@email_receipt)
    assert_response :success
  end

  test "should get edit" do
    get edit_email_receipt_url(@email_receipt)
    assert_response :success
  end

  test "should update email_receipt" do
    patch email_receipt_url(@email_receipt), params: { email_receipt: { comic_id: @email_receipt.comic_id, subscriber_id: @email_receipt.subscriber_id, subscription_id: @email_receipt.subscription_id } }
    assert_redirected_to email_receipt_url(@email_receipt)
  end

  test "should destroy email_receipt" do
    assert_difference('EmailReceipt.count', -1) do
      delete email_receipt_url(@email_receipt)
    end

    assert_redirected_to email_receipts_url
  end
end
