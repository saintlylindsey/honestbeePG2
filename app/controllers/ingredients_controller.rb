class IngredientsController < ApplicationController

	def index
	  @ingredients = Ingredient.all
	end

	def show
	  @ingredient = Ingredient.find(params[:id])
	  @ingredient_recipes = @ingredient.recipes.all
	end

	private
	def ingredient_params
	    params.require(:ingredient).permit(:name)
	end
end
