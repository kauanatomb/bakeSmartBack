class IngredientsController < ApplicationController
  before_action :set_ingredient, only: %i[show update destroy]
  
  def index
    @ingredients = Ingredient.all
    render json: @ingredients.as_json(include: [:category, :measurement_unit])
  end

  def show
    render json: @ingredient.as_json(include: [:category, :measurement_unit])
  end

  def create
    @ingredient = Ingredient.new(ingredient_params).merge(owner_id: current_user.id)

    if @ingredient.save
      render json: @ingredient, status: :created
    else
      render json: @ingredient.errors, status: :unprocessable_entity
    end
  end

  def update
    if @ingredient.update(ingredient_params)
      render json: @ingredient, status: :ok
    else
      render json: @ingredient.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @ingredient.destroy
    head :no_content
  end
  
  private

  def set_ingredient 
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :category_id, :measurement_unit_id, :price, :brand, :quantity)
  end
end