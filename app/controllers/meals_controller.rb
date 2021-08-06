class MealsController < ApplicationController

  def index
  end
  
  def show
  end

  def create
    #Use method to identify provider, and parse data accordingly
    if getProvider.match(/www.themealdb.com/)
      Meal.parseMealsDB(meal_params(Meal.MealsDB_params))
    end
    # binding.pry
  end

  def update
  end

  def destroy
  end

  private

  def meal_params(*args)
    params.require(:meals)[0].permit(*args)
  end
  def getProvider()
    params.require(:provider)
  end
  
end
