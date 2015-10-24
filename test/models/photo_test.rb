require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
	PASSWORD = '1234567890'
	TEST_PHOTO_PATH = "#{Rails.root}/db/photos/1.jpg";

  def setup
  	@user = User.new(name: 'test', email: 'test@test.com', password: PASSWORD, password_confirmation: PASSWORD)
  	@user.save
  	@photo = @user.photos.build(title: 'test', file: File.new(TEST_PHOTO_PATH))
  end

  test "should be valid" do
  	assert @photo.valid?, @photo.errors.full_messages
  end

  test "user_id should be present" do
  	@photo.user_id = nil
  	assert_not @photo.valid?
  end

  test "title should not be longer than 1000 characters" do
  	@photo.title = "a" * 1001
  	assert_not @photo.valid?
  end

  test "file should be present" do
  	@photo.file = nil
  	assert_not @photo.valid?
  end
end
