class RecipesController < ApplicationController
	before_action :find_recipe, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	require 'openfoodfacts'
	require 'json'

	def index
		@recipes=Recipe.all
		if params[:search]
			@recipes = Recipe.search(params[:search]).order("created_at DESC")
		else 
			 @recipes = Recipe.all.order('created_at DESC')
		end
	end

	def show
		 @reviews = Review.where(recipe_id: @recipe.id).order("created_at DESC")
		  if @reviews.blank?
      	@avg_review = 0
    	else
      	@avg_review = @reviews.average(:rating).round(2)
    	end
	end

	def new
		@recipe = current_user.recipes.new
		@ingredients = Ingredient.where(hb: true)
	end

	def create
		@recipe = current_user.recipes.new(recipe_params)
		if @recipe.save
			flash[:notice] = "Successfully created a new recipe"
			redirect_to @recipe
		else
			render :action => :new
		end
	end

	def edit
		@ingredients = Ingredient.where(hb: true)
	end

	def update
		if @recipe.update(recipe_params)
			redirect_to @recipe
		else
			render :action => :edit
		end
	end

	def destroy
		@recipe.destroy
		flash[:notice] = "Successfully deleted the recipe"
		redirect_to :action => :index
	end

	private

	def recipe_params
#		params.require(:recipe).permit(:name, :description, :image, :rating, ingredients_attributes: [:id, :name, :_destroy], instructions_attributes: [:id, :step, :_destroy], :ingredient_ids => [], category_ids: [])
		params.require(:recipe).permit(:name, :description, :image, :rating, ingredients_attributes: [:name, :_destroy], instructions_attributes: [:id, :step, :_destroy], :ingredient_ids => [], category_ids: [])
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end
end


