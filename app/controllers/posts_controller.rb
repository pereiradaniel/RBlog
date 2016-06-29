class PostsController < ApplicationController

	before_filter :authorize, :except => [:index, :show]

	def index
		@posts = Post.all
	end

	def show
		@post = Post.find(params[:id])
	end

	def new
		@post = Post.new
	end

	def edit
		@post = Post.find(params[:id])
	end

	def create
		@post = Post.new(params.require(:post).permit(:text, :user_id))

		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def update
		@post = Post.find(params[:id])

		if @post.user_id == current_user.id
			if @post.update(post_params)
				redirect_to @post
			else
				render 'edit'
			end
		else
			redirect_to @post
		end
	end

	def destroy
		@post = Post.find(params[:id])

		if @post.user_id == current_user.id 
			@post.destroy
		else
		end
		redirect_to posts_path
	end

	private
	def post_params
		params.require(:post).permit(:text, :user_id)
	end

end
