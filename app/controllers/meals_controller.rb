require 'net/http'
class MealsController < ApplicationController

  def index
  end
  
  def show
    mealObj = Meal.find_by(meal_params(:id))
    if updatedMealObj.nil? 
      render json: {message: "Record with ID: #{meal_params(:id).values.first} doesn't exist"}
    else
      render json: mealObj
    end
  end

  def discover #placeholder - Used to find recipes from 3rd parties. Search using other's API
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

  def import #import from website, :scrape => [FoodNetwork]
    # url = "https://www.foodnetwork.com/recipes/puerto-rican-style-stuffed-flank-steak-5307440"
    # meal_data = FoodNetwork_Scraper.new(url)
    binding.pry
    if meal_data.valid?
      render json: meal_data
    else
      render json: meal_data.error
    end
  end

  def create
    newMeal = Meal.new(meal_params(:title,:category,:area,:source,:instructions => [],:tags => [],:ingredients => {}))
    if newMeal.save
      render json: newMeal
    else
      render json: newMeal.errors.messages
    end
  end

  def update
    updatedMealObj = Meal.find_by(meal_params(:id))
    if updatedMealObj.nil? 
      render json: {message: "Record with ID: #{meal_params(:id).values.first} doesn't exist"}
    elsif updatedMealObj.update(meal_params(:title,:category,:area,:source,:instructions => [],:tags => [],:ingredients => {}))
      render json: updatedMealObj
    else
      reder json: updatedMealObj.errors.messages
    end
  end

  def destroy
    mealObj = Meal.find_by(meal_params(:id))
    if mealObj.nil?
      render json: {message: "Record with ID: #{meal_params(:id).values.first} doesn't exist"}
    elsif mealObj.delete
      render json: mealObj
    else
      render json: mealObj.errors.messages
    end
  end

  private

  def meal_params(*args)
    params.require(:meals)[0].permit(args)
  end
  def getProvider()
    params.require(:provider)
  end
  
end
