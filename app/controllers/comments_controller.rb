class CommentsController < ApplicationController
	
	before_filter :authorize, :except => [:index, :show]

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		redirect_to post_path(@post)
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		
		if user_can_edit(@post) or user_can_edit(@comment)
			@comment.destroy
		end
		redirect_to post_path(@post)
	end

	private
	def comment_params
		params.require(:comment).permit(:commenter, :body, :user_id)
	end
end
