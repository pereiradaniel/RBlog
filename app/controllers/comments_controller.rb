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
		if @comment.user_id == current_user.id or @post.user_id == current_user.id
			@comment.destroy
		else
		end
		redirect_to post_path(@post)
	end

	private
	def comment_params
		params.require(:comment).permit(:commenter, :body, :user_id)
	end
end
