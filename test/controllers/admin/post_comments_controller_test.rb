require "test_helper"

class Admin::PostCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_post_comments_edit_url
    assert_response :success
  end
end
