require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    user = users(:one)
    sign_in user

    get dashboard_index_url
    assert_response :success
  end
end
