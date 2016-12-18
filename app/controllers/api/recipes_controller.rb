class Api::RecipesController < ApplicationController

	before_action :require_user, only: [:create]

  def index
    @recipes = Recipe.all
    @ingredients = Ingredient.all

    # @recipes=Recipe.find(params[:id])
    # @find_recipes.ingredients.each do |i|
    # 	i.name
    # end

    respond_to do |format|
      format.json { render :json => {:recipes => @recipes, :ingredients => @ingredients} }
    end
  end

  def create
    ingredient_names = params[:ingredients]
    new_ingredients = ingredient_names.map { |name| Ingredient.create(name: name) }

    recipe =  Recipe.create(
                user: current_user,
                ingredients: new_ingredients,
                name: params[:name],
                description: params[:description]
              )

    if recipe.valid?
      render json: recipe
    else
      render json: { errors: recipe.errors.full_messages}, status: :unprocessable_entity
    end
  end

end