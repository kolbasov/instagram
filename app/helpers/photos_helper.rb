module PhotosHelper
	def no_photos?
		!@photos.any?
	end
end
