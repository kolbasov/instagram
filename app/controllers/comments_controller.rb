class CommentsController < ApplicationController
	# def create 
	# 	@photo = Photo.find(params[:id])
	# 	comment = @photo.comments.build(comment_params)
	# 	comment.user_id = current_user.id
	# 	comment.save
	# 	redirect_to @photo
	# end
	def create 
		@photo = Photo.find(params[:id])
		comment = @photo.comments.build(comment_params)
		comment.user_id = current_user.id
		respond_to do |format|
      if comment.save
        format.html { redirect_to @photo }
        format.js { render 'success', locals: { comment: comment } }
      else
        redirect_to @photo
      end
    end
	end

	private 
		def comment_params
			params.require(:comment).permit(:text)
		end	
end
