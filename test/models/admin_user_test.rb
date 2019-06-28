require 'test_helper'

class AdminUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = AdminUser.new(name: "Example User", mail: "user@example.com",
    password: "foobar", password_confirmation: "foobar")
  end

  test "mail addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.mail = @user.mail.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  test "mail addresses should be saved as lower-case" do
    mixed_case_mail = "Foo@ExAMPle.CoM"
    @user.mail = mixed_case_mail
    @user.save
    assert_equal mixed_case_mail.downcase, @user.reload.mail
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
