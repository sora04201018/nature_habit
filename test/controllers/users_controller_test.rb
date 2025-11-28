require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    sign_in users(:one)
    get mypage_url
    assert_response :success
  end
end
