require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "abc", email: "trung@gmail.com",
      password: "123456", password_confirmation: "123456")
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email validation should accept valid" do
    emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp alice+bob@baz.cn]
    emails.each do |email|
      @user.email = email
      assert @user.valid?, "#{email.inspect} should be valid"
    end  
  end 

  test "email should saved lower-case" do
    lower_case_email = "trung@gmail.com"
    @user.email = lower_case_email
    @user.save
    assert_equal lower_case_email.downcase, @user.reload.email
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = "    "
    assert_not @user.valid?
  end

  test "password should be minimum 6" do
    @user.password = @user.password_confirmation = "12345"
    assert_not @user.valid?
  end  
end
