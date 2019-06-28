require 'test_helper'

class MailUserControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get mail_user_new_url
    assert_response :success
  end

end
