class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show update destroy]
  skip_before_action :authenticate_user!, only: %i[show]

  def index
    @recipes = Recipe.where(user_id: current_user.id)
    render json: @recipes.as_json(include: { 
      recipe_ingredients: { 
        except: [:recipe_id, :ingredient_id, :measurement_unit_id, :created_at, :updated_at],
        include: { 
          ingredient: { only: [:id, :name, :quantity], include: {
            measurement_unit: { only: [:id, :name] },
          } }, 
          measurement_unit: { only: [:id, :name] }
        }
      }
    })
  end

  def show
    render json: @recipe.as_json(include: { 
      recipe_ingredients: { 
        except: [:recipe_id, :ingredient_id, :measurement_unit_id, :created_at, :updated_at],
        include: { 
          ingredient: { only: [:id, :name, :quantity], include: {
            measurement_unit: { only: [:id, :name] },
          } }, 
          measurement_unit: { only: [:id, :name] }
        }
      }
    })
  end

  def create
    @recipe = Recipe.new(recipe_params.merge(user_id: current_user.id))
    if @recipe.save
      render json: @recipe, status: :created
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  def update
    if @recipe.update(recipe_params)
      render json: @recipe, status: :ok
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy
    head :no_content
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :cook_time, recipe_ingredients_attributes: %i[id ingredient_id quantity measurement_unit_id])
  end
end
