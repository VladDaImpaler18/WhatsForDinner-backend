class MealsController < ApplicationController

  def index
  end
  
  def show
  end

  def create
    #Use method to identify provider, and parse data accordingly
    binding.pry
  end

  def update
  end

  def destroy
  end

  private

  def meal_params
    params.require(:meals).permit(*args)
  end

end
