class PhotosController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]

	def index
		@photos = Photo.all
		# For posting a new photo from the home page.
		@photo = Photo.new
	end

	def search
		@photos = Photo.with_tag(params[:q])
		@photo = Photo.new
		render 'index'
	end

	def new
		@photo = Photo.new
	end

	def create
		@photo = current_user.photos.build(photo_params)
		if @photo.save
			redirect_to root_url
		else
			render 'new'
		end
	end

	def show
		@photo = Photo.find(params[:id])
		@comment = Comment.new
		@comments = @photo.comments
	end

	private
		def photo_params
			params.require(:photo).permit(:title, :file)
		end
end
