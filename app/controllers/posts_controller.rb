class PostsController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show]
  before_action :post_find, only: [:show, :edit, :update, :destroy]
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post successfully created"
      redirect_to root_path
    else
      flash[:error] = "Post has error with created"
      render 'new'
    end
  end

  def show
     @comments = @post.comments
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post successfully updated"
      redirect_to post_path(@post.id)
    else
      flash[:error] = "Post has error with created"
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end
private
  def post_find
   @post = Post.find_by(id: params[:id])
  end

  def post_params
   params.require(:post).permit(:user_id, :title, :body, {photos: []})
  end
end
