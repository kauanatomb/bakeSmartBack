class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show update destroy]
  skip_before_action :authenticate_user!

  def show
    render json: @category
  end

  def index
    @categories = Category.all
    render json: @categories
  end

  def create
    @category = Category.new(category_params)
    authorize @category 
    if @category.save
      render json: @category, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @category
    if @category.update(category_params)
      render json: @category, status: :ok
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @category
    @category.destroy
    head :no_content
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end