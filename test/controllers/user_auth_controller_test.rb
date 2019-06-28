require 'test_helper'

class UserAuthControllerTest < ActionDispatch::IntegrationTest
  test "should get mailpost" do
    get user_auth_mailpost_url
    assert_response :success
  end

end
