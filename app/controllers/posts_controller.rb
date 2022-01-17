class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :get_post_info, only: [:edit, :update, :show, :destroy]


  def index
    @posts = Post.all.order("created_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end


  def edit
    
  end

  def update
    @post.update(post_params)

    if @post.save
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def show
    
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end



  private

  def post_params
    params.require(:post).permit(:title, :sentence,
                                 :image).merge(user_id: current_user.id)
  end

  def get_post_info
    @post = Post.find(params[:id])
  end

end
