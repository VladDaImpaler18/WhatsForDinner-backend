require 'net/http'
require 'net/https'
##This class fetches JSON data from the 3rd party website MealDBFetcher and parses them into a Meals Model acceptible format
#Notes to self, create this in a different branch. May not end up working out as intended.
class MealDbFetcher < ApplicationRecord
    @@payload = {}
    @@testing_API_KEY=1 #For development testing purposes only
    @@base_uri = "https://www.themealdb.com/api/json/v1/#{testing_API_KEY}/"
    
    #service = by_title, by_main_ingredient, random, list_all_category
    def initialize(service, request)
        response = Net::HTTP.get(URI(@@base_uri + service))

    end
    def MealsDB_params
        [:strMeal, :strCategory, :strArea, :strInstructions,:strTags,:strYoutube,:strIngredient1,:strIngredient2,:strIngredient3,:strIngredient4,:strIngredient5,:strIngredient6,:strIngredient7,:strIngredient8,:strIngredient9,:strIngredien10,
        :strIngredient11,:strIngredient12,:strIngredient13,:strIngredient14,:strIngredient15,:strIngredient16,:strIngredient17,:strIngredient18,:strIngredient19,:strIngredient20,
        :strMeasure1,:strMeasure2,:strMeasure3,:strMeasure4,:strMeasure5,:strMeasure6,:strMeasure7,:strMeasure8,:strMeasure9,:strMeasure10,:strMeasure11,:strMeasure12,
        :strMeasure13,:strMeasure14,:strMeasure15,:strMeasure16,:strMeasure17,:strMeasure18,:strMeasure19,:strMeasure20,:strSource]
    end
    
    def 
    url_random =   "random.php"
    url_by_title = "search.php?s=" #+ 'Clam chowder'
    url_by_main_ingredient = "filter.php?i=" #+ 'chicken_breast'
    #=> {meals:[ {"strMeal"}, {"strMeal"}, {"strMeal"} ]}

    url_list_all_category = "list.php?c=list"
    #=> {meals:[ {"strCategory"}, {"strCategory"}, {"strCategory"} ]}
    def parseMealsDB(payload)
        mealObj={}
        mealObj["title"]=payload[:strMeal]
        mealObj["category"]=payload[:strCategory]
        mealObj["area"]=payload[:strArea]
        mealObj["instructions"]=payload[:strInstructions].split(/[\r][\n]*/).reject { |s| s.nil? || s.strip.empty? } #Splits paragraph instruction into steps, broken down by \r\n combination
        mealObj["tags"]=payload[:strTags].split(/,/) unless payload[:strTags].nil?
        #videoLink=payload[:strYoutube]
        #image=payload[:]
        ingredients={}
        materials=[]
        amounts=[]
        payload.each_pair do |k,v|
            if k.include? "Ingredient"
                materials.push(v)
            elsif k.include? "Measure"
                amounts.push(v)
            end
        end
        (0..20).each do |i|
            break if materials[i].empty?
            ingredients.store(materials[i],amounts[i])
        end
        mealObj["ingredients"] = ingredients
        mealObj["source"]=payload[:strSource]
        return mealObj
    end
end