class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show update destroy]

  def index
    @recipes = Recipe.where(user_id: current_user.id).map do |recipe|
      recipe.as_json(include: { 
        recipe_ingredients: { 
          except: [:recipe_id, :ingredient_id, :measurement_unit_id, :created_at, :updated_at],
          include: { 
            ingredient: { only: [:id, :name, :quantity, :price], include: {
              measurement_unit: { only: [:id, :name, :symbol] },
            } }, 
            measurement_unit: { only: [:id, :name] }
          }
        }
      }).merge(total_cost: calculate_recipe(recipe))
    end
    render json: @recipes
  end

  def show
    render json: @recipe.as_json(include: { 
      recipe_ingredients: { 
        except: [:recipe_id, :ingredient_id, :measurement_unit_id, :created_at, :updated_at],
        include: { 
          ingredient: { only: [:id, :name, :quantity, :price], include: {
            measurement_unit: { only: [:id, :name, :symbol] },
          } }, 
          measurement_unit: { only: [:id, :name] }
        }
      }
    }).merge(total_cost: calculate_recipe(@recipe))
  end

  def create
    @recipe = Recipe.new(recipe_params.merge(user_id: current_user.id))
    if @recipe.save
      render json: @recipe.as_json, status: :created
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

  def calculate_recipe(recipe)
    total_cost = 0
  
    recipe.recipe_ingredients.each do |recipe_ingredient|
      cost = calculate_cost(recipe_ingredient)
      if cost.nil?
        render json: { error: 'Invalid conversion' }, status: :unprocessable_entity
        return
      else
        total_cost += cost
      end
    end
  
    total_cost
  end

  private

  def calculate_cost(recipe_ingredient)
    ingredient = recipe_ingredient.ingredient
    measurement_unit = recipe_ingredient.measurement_unit.symbol
    quantity = recipe_ingredient.quantity
    ingredient_unit = ingredient.measurement_unit.symbol
    ingredient_quantity = ingredient.quantity
    ingredient_price = ingredient.price

    conversion_factors = {
      ['kg', 'g'] => 1000,
      ['l', 'ml'] => 1000,
      ['l', 'g'] => 1000,
      ['g', 'kg'] => 1/1000.0,
      ['ml', 'l'] => 1/1000.0,
      ['g', 'l'] => 1/1000.0,
    }

    larger_units = ['kg', 'l']

    if conversion_factors[[ingredient_unit, measurement_unit]]
      if larger_units.include?(ingredient_unit)
        ((quantity / (ingredient_quantity * 1000)) * ingredient_price).round(2)
      else
        (((quantity * 1000) / ingredient_quantity) * ingredient_price).round(2)
      end
    elsif measurement_unit
      (ingredient.price * quantity / ingredient_quantity).round(2)
    else
      nil
    end
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :cook_time, recipe_ingredients_attributes: %i[id ingredient_id quantity measurement_unit_id])
  end
end
