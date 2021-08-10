require 'net/http'
class MealsController < ApplicationController

  def index
  end
  
  def show
  end

  def discover #placeholder - Used to find recipes from 3rd parties.
    testing_API_KEY=1
    url_random =   "https://www.themealdb.com/api/json/v1/#{testing_API_KEY}/random.php"
    url_by_title = "https://www.themealdb.com/api/json/v1/#{testing_API_KEY}/search.php?s=#{`Clam chowder`}"
    url_by_main_ingredient = "www.themealdb.com/api/json/v1/#{testing_API_KEY}/filter.php?i=#{`chicken_breast`}"
    #=> {meals:[ {"strMeal"}, {"strMeal"}, {"strMeal"} ]}

    url_list_all_category = "www.themealdb.com/api/json/v1/#{testing_API_KEY}/list.php?c=list"
    #=> {meals:[ {"strCategory"}, {"strCategory"}, {"strCategory"} ]}

    response = Net::HTTP.get(URI(url_random))
    payload = JSON.parse(response)
    payload["provider"]="www.themealdb.com"
    ## mealDB parser then render to front end
    mealAttr = Meal.parseMealsDB(meal_params(Meal.MealsDB_params))
    newMeal = Meal.new(mealAttr)
    # Front end allows changes then saves it in our format to controller#create
    render json: newMeal
  end

  def create
    newMeal = Meal.new(meal_params(:title,:category,:area,:source,:instructions => [],:tags => [],:ingredients => {}))
    if newMeal.save
      render json: newMeal
    else
      render json: newMeal.errors.messages
  end

  def update
    mealObj = Meal.find_by(:id=>meal_params(:id))
    mealObj.update(meal_params(:title,:category,:area,:source,:instructions => [],:tags => [],:ingredients => {}))
  end

  def destroy
  end

  private

  def meal_params(*args)
    params.require(:meals)[0].permit(args)
  end
  def getProvider()
    params.require(:provider)
  end
  
end
