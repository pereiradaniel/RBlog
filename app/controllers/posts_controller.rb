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
		if !user_can_edit(@post)
			redirect_to @post
		end
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

		if !user_can_edit(@post)
			redirect_to @post
		else
			if @post.update(post_params)
				redirect_to @post
			else
				render 'edit'
			end
		end
	end

	def destroy
		@post = Post.find(params[:id])
		if !user_can_edit(@post)
			redirect_to @post
		else
			@post.destroy
			redirect_to posts_path
		end
	end

	private
	def post_params
		params.require(:post).permit(:text, :user_id)
	end

end
