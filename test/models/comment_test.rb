require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  PASSWORD = '1234567890'
	TEST_PHOTO_PATH = "#{Rails.root}/db/photos/1.jpg";

  def setup
  	@user = User.new(name: 'test', email: 'test@test.com', password: PASSWORD, password_confirmation: PASSWORD)
  	@user.save
  	@photo = @user.photos.build(title: 'test', content: File.new(TEST_PHOTO_PATH))
  	@comment = @photo.comments.build(text: 'test')
  end

  test "should be valid" do
  	assert @comment.valid?, @comment.errors.full_messages
  end

  test "text should be present" do
  	@comment.text = nil
  	assert_not @comment.valid?
  end
end
