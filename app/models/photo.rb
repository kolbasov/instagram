class Photo < ActiveRecord::Base
	JOIN_COMMENTS = "left join comments on comments.photo_id = photos.id"
	QUERY_TAG = 'photos.title like :tag or comments.text like :tag'

	belongs_to :user
	has_many :comments

	default_scope -> { order(created_at: :desc) }

	has_attached_file :file
	validates_attachment_content_type :file, content_type: ["image/jpeg", "image/png"]
	validates_attachment_size :file, in: 0..1.megabytes
	
	validates :user_id, presence: true
	validates :title, length: { maximum: 1000 }
	validates :file, presence: true

	def Photo.with_tag(tag)
		Photo.joins(JOIN_COMMENTS).where(QUERY_TAG, { tag: "%##{tag}%" }).distinct
	end
end
