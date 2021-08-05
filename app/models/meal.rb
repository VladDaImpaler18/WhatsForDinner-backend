class Meal < ApplicationRecord
   
    

    def self.parseInstructions(full_instructions)
        #Splits paragraph instruction into steps, broken down by \r\n combination
        full_instructions.split(/[\r][\n]*/).reject { |s| s.nil? || s.strip.empty? } 
    end
end
