class PostsController < ApplicationController

	def index
		@posts = Post.all
		@category = Category.all
		@markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

		# search
	  	if params[:search]
	    	@posts = Post.search(params[:search]).order("created_at DESC")
	  	else
	    	@posts = Post.all.order('created_at DESC')
	  	end
	end

	def show
		@post = Post.find(params[:id])
		@comment = Comment.new(:post => @post)	
		@markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

		# increase post's view 
		Post.increment_counter(:view_count, @post.id)
	end

	def new
		@post = Post.new
		@category = Category.all
	end

	def create
		@post = Post.new(post_params)
		if(@post.save)
			redirect_to :action => 'show', :id => @post.id
		else
			render :action => "new"
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(post_params)
			redirect_to post_path, :notice  => "Your post has been updated!"
		else 
			# render edit view
			render "edit"
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path, :notice => "Your post has been deleted!"
	end

	private 
	def post_params
	  	params.require(:post).permit(:title, :body, :category_id)
	end
end
