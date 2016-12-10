class RecipesController < ApplicationController
	before_action :find_recipe, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@recipes=Recipe.all
		if params[:search]
			@recipes = Recipe.search(params[:search]).order("created_at DESC")
		else 
			 @recipes = Recipe.all.order('created_at DESC')
		end
	end

	def show
	end

	def new
		@recipe = current_user.recipes.new
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


