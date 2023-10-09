class Admin::CategoriesController < ApplicationController
  before_action :get_category_id, only: [:edit, :update]

  def index
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "新しいカテゴリを作成しました"
      redirect_to admin_categories_path
    else
      @categories = Category.all
      render :index
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "カテゴリ情報を更新しました"
      redirect_to admin_categories_path
    else
      render :edit
    end

    def destroy
      @category.destroy
      redirect_to categories_path
    end

  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def get_category_id
    @category = Category.find(params[:id])
  end


end
