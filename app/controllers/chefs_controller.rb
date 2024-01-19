class ChefsController < ApplicationController

    def new
        @chef = Chef.new
    end

    def create
        @chef = Chef.new(chef_params)
        if @chef.save
            flash[:success] = "Welcome #{@chef.chefname} to MyRecipes App!"
            redirect_to chefs_path(@chef)
        else
            render :new, status: :unprocessable_entity
        end
    end

    private
        def chef_params 
            params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
        end

end