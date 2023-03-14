require "test_helper"

class Public::GroupMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_group_messages_index_url
    assert_response :success
  end
end
