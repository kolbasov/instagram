require 'test_helper'

class UserTest < ActiveSupport::TestCase
	PASSWORD = '1234567890'

  def setup
  	@user = User.new(name: "test", email: "test@test.com", password: PASSWORD, password_confirmation: PASSWORD)
  end

  test "should be valid" do
  	assert @user.valid?, @user.errors.full_messages
  end

  test "name should be present" do
  	@user.name = nil
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = nil
  	assert_not @user.valid?
  end

  test "name should not be longer than 50 characters" do 
  	@user.name = "a" * 51
  	assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
  	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |email|
    	@user.email = email
    	assert @user.valid?, "#{email.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
  	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |email|
    	@user.email = email
    	assert_not @user.valid?, "#{email.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
  	dup = @user.dup
  	@user.save
  	assert_not dup.valid?
  end

  test "email	addresses should be saved as lower-case" do
  	mixed = "FooBar@tEst.coM"
  	@user.email = mixed
  	@user.save
  	assert_equal mixed.downcase, @user.reload.email
  end

  test "user names should be unique" do
  	dup = @user.dup
  	dup.email = "diff@test.com"
  	@user.save
  	assert_not dup.valid?
  end

  test "password should be present" do
  	@user.password = @user.password_confirmation = " " * 6
  	assert_not @user.valid?
  end

  test "password should be at least 6 characters long" do
  	@user.password = "a" * 5
  	assert_not @user.valid?
  end
end