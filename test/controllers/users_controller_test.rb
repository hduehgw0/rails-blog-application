require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get users_show_url
    assert_response :success
  end

  test "should get following" do
    get users_following_url
    assert_response :success
  end

  test "should get followers" do
    get users_followers_url
    assert_response :success
  end
end
