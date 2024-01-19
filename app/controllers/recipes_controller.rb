class RecipesController < ApplicationController
    before_action :set_recipe, only: [:show, :edit, :update]

    def index
        @recipes = Recipe.paginate(page: params[:page], per_page: 5)
    end

    def show
        # @recipe = Recipe.find(params[:id])
    end

    def new
        @recipe = Recipe.new
    end

    def create
        @recipe = Recipe.new(recipe_params)
        @recipe.chef = Chef.first
        if @recipe.save
            flash[:success] = "Recipe was created successfully!"
            redirect_to recipe_path(@recipe)
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        # @recipe = Recipe.find(params[:id])
    end

    def update
        # @recipe = Recipe.find(params[:id])
        if @recipe.update(recipe_params)
            flash[:success] = "Recipe was updated successfully"
            redirect_to(recipe_path(@recipe))
        else 
            render "edit"
        end
    end

    def destroy
        @recipe = Recipe.find(params[:id])
        @recipe.destroy
        flash[:success] = "Recipe deleted successfully"
        redirect_to recipes_path, status: :see_other
    end

    private
        def set_recipe
            @recipe = Recipe.find(params[:id])
        end

        def recipe_params
            params.require(:recipe).permit(:name, :description)
        end
end