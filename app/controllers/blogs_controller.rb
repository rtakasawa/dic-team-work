class BlogsController < ApplicationController
  before_action :set_blog, only: [:edit, :update, :destroy, :show]
  before_action :login_check, only: [:new, :create, :edit, :update, :destroy, :show]

  def index
    @blogs = Blog.all
  end
  
  def new
    @blog = Blog.new
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to blogs_path, flash: {success: "ブログを作成しました"}
    else
      render :new
    end
  end

  def edit
    current_user.id == @blog.user.id
  end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, flash: {success: "ブログを編集しました"}
    else
      render :edit
    end
  end

  def destroy
    current_user.id == @blog.user.id
    @blog.destroy
    redirect_to blogs_path, flash: {danger: "ブログを削除しました"}
  end

  def show; end

  private
  def blog_params
    params.require(:blog).permit(:id, :title, :content, )
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end
end