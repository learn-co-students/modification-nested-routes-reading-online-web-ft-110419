class PostsController < ApplicationController

  def index
    if params[:author_id]
      @posts = Author.find(params[:author_id]).posts
    else
      @posts = Post.all
    end
  end

  def show
    if params[:author_id]
      @post = Author.find(params[:author_id]).posts.find(params[:id])
    else
      @post = Post.find(params[:id])
    end
  end

  def new
    @post = Post.new
    if !params[:author_id].blank?
      @author = Author.find_by_id(params[:author_id].to_i)
      if @author
        @post.author = @author
      else 
        flash[:alert] = "Author does not exist."
        redirect_to authors_path
      end
    end
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find_by_id(params[:id])
    if params[:author_id]
      @author = Author.find_by_id(params[:author_id].to_i)
      if !@author
        flash[:alert] = "Author not found."
        redirect_to authors_path
      elsif !@post || @author != @post.author 
        flash[:alert] = "Post not found."
        redirect_to author_posts_path(@author)
      end
    elsif !@post
      flash[:alert] = "Post not found."
      redirect_to posts_path 
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :author_id)
  end
end
