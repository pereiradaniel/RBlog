class PostsController < ApplicationController

	def index
		@posts = Post.all
	end

	def show
		@post = Post.find(params[:id])
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(params.require(:post).permit(:text, :text))

		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	private
	def post_params
		params.require(:post).permit(:text)
	end

end
