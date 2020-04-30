class BlogsController < ApplicationController
  before_action :set_blog, only: [:edit, :update, :destroy, :show]
  before_action :login_check, only: [:new, :create, :edit, :update, :destroy, :show]

  def index
    @blogs = Blog.all
  end
  
  def new
    if params[:back]
      @blog = current_user.blogs.build(blog_params)
      render 'new'
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
      render 'new'
    else
      if @blog.save
        redirect_to blogs_path, flash: {success: "ブログを作成しました"}
      else
        render :new
      end
    end
  end

  def edit
    if current_user.id == @blog.user.id
    else
      redirect_to blogs_path, flash: {danger: "自分の記事以外の編集は出来ません"}
    end
  end

  def update
    if params[:back]
      render :edit
    else
      if @blog.update(blog_params)
        redirect_to blogs_path, flash: {success: "ブログを編集しました"}
      else
        render :edit
      end
    end
  end

  def destroy
    if current_user.id == @blog.user.id
      @blog.destroy
      redirect_to blogs_path, flash: {danger: "ブログを削除しました"}
    else
      redirect_to blogs_path, flash: {danger: "自分の記事以外の削除は出来ません"}
    end
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