class Meal < ApplicationRecord
   
    

    def self.parseInstructions(full_instructions)
        #Splits paragraph instruction into steps, broken down by \r\n combination
        full_instructions.split(/[\r][\n]*/).reject { |s| s.nil? || s.strip.empty? } 
    end
    def parseIngredients(payload)
        binding.pry
        #params[:meals][0].each_pair do |k,v|
    end
    
    
    def self.parseMealsDB(payload)
        binding.pry
    end
end

# :strMeal
# :strCategory
# :strArea
# :strInstructions
# :strTags
# :strYoutube
# :strIngredient1
# :strIngredient2
# :strIngredient3
# :strIngredient4
# :strIngredient5
# :strIngredient6
# :strIngredient7
# :strIngredient8
# :strIngredient9
# :strIngredient10
# :strIngredient11
# :strIngredient12
# :strIngredient13
# :strIngredient14
# :strIngredient15
# :strIngredient16
# :strIngredient17
# :strIngredient18
# :strIngredient19
# :strIngredient20
# :strMeasure1
# :strMeasure2
# :strMeasure3
# :strMeasure4
# :strMeasure5
# :strMeasure6
# :strMeasure7
# :strMeasure8
# :strMeasure9
# :strMeasure10
# :strMeasure11
# :strMeasure12
# :strMeasure13
# :strMeasure14
# :strMeasure15
# :strMeasure16
# :strMeasure17
# :strMeasure18
# :strMeasure19
# :strMeasure20
# :strSource
