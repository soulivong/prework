class CategoriesController < ApplicationController

  def index
    @cates = Category.all
  end

  def new
    @cate = Category.new
  end

  def create
    @cate = Category.new(cate_params)
    if(@cate.save)
      redirect_to :action => 'show', :id => @cate.id
    else
      render :action => "new"
    end
  end

  def show
    @cate = Category.find(params[:id])
    @title = @cate.name
    @posts = @cate.posts
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  def edit
    @cate = Category.find(params[:id])
  end

  def update 
    @cate = Category.find(params[:id])
    if @cate.update_attributes(cate_params)
      redirect_to categories_path, :notice  => "Your category has been updated!"
    else 
      # render edit view  
      render "edit"
    end
  end
  def destroy
    @cate = Category.find(params[:id])
    @cate.destroy
    redirect_to categories_path, :notice => "Your category has been deleted!"
  end

  private 
  def cate_params
      params.require(:category).permit(:name)
  end
end
