class Api::RecipesController < ApplicationController

	before_action :require_user, only: [:create]

  def index
    @recipes = Recipe.all
    respond_to do |format|
      format.json { render :json => @recipes }
    end
  end

end