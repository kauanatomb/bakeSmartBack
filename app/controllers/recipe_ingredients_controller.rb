class RecipeIngredientsController < ApplicationController
  before_action :set_recipe_ingredient, only: %i[show destroy]
  before_action :authenticate_user!, only: %i[destroy]

  def index
    @recipe_ingredients = RecipeIngredient.all
    render json: @recipe_ingredients.as_json(include: [:recipe, :ingredient])
  end

  def show
    render json: @recipe_ingredient.as_json(include: [:recipe, :ingredient, :measurement_unit])
  end

  def destroy
    @recipe_ingredient.destroy
    head :no_content
  end

  private

  def set_recipe_ingredient
    @recipe_ingredient = RecipeIngredient.find(params[:id])
  end

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:recipe_id, :ingredient_id, :quantity, :measurement_unit_id)
  end
end