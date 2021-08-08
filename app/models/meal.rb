class Meal < ApplicationRecord
    
    def self.MealsDB_params
        [:strMeal, :strCategory, :strArea, :strInstructions,:strTags,:strYoutube,:strIngredient1,:strIngredient2,:strIngredient3,:strIngredient4,:strIngredient5,:strIngredient6,:strIngredient7,:strIngredient8,:strIngredient9,:strIngredien10,
        :strIngredient11,:strIngredient12,:strIngredient13,:strIngredient14,:strIngredient15,:strIngredient16,:strIngredient17,:strIngredient18,:strIngredient19,:strIngredient20,
        :strMeasure1,:strMeasure2,:strMeasure3,:strMeasure4,:strMeasure5,:strMeasure6,:strMeasure7,:strMeasure8,:strMeasure9,:strMeasure10,:strMeasure11,:strMeasure12,
        :strMeasure13,:strMeasure14,:strMeasure15,:strMeasure16,:strMeasure17,:strMeasure18,:strMeasure19,:strMeasure20,:strSource]
    end
    
    def self.parseMealsDB(payload)
        title=payload[:strMeal]
        category=payload[:strCategory]
        area=payload[:strArea]
        instructions=payload[:strInstructions].split(/[\r][\n]*/).reject { |s| s.nil? || s.strip.empty? } #Splits paragraph instruction into steps, broken down by \r\n combination
        tags=payload[:strTags].split(/,/)
        #videoLink=payload[:strYoutube]
        #image=payload[:]
        ingredientsList={}
        ingredients=[]
        amounts=[]
        payload.each_pair do |k,v|
            if k.include? "Ingredient"
                ingredients.push(v)
            elsif k.include? "Measure"
                amounts.push(v)
            end
        end
        (0...20).each do |i|
            break if ingredients[i].empty?
            ingredientsList.store(ingredients[i],amounts[i])
        end
        sourceURL=payload[:strSource]
        newMeal = Meal.new(:title => title, :category => category, :area => area, :source => sourceURL, :instructions => instructions, :tags => tags, :ingredients => ingredientsList )
        
    end
end