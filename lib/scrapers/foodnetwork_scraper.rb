require 'json'
class FoodNetwork_Scraper

    attr_accessor :payload, :error

    def initialize(url)
        check_url(url)
        scrape_data(url)
    end

    def valid?
        @error.empty?
    end

    private

    def scrape_data(url)
        #ingredients will be entire line, later it will be broken to a hash
        ingredients = []
        directions = []
        
        begin
            # Fetch and parse HTML document
            doc = Nokogiri::HTML(URI.open(url))
            
            # Title 
            title_path = 'span.o-AssetTitle__a-HeadlineText'
            title = doc.css(title_path).text.strip
            
            # Category

            # Area

            # Instructions
            instructions_path = 'ol li.o-Method__m-Step'
            doc.css(instructions_path).each { |el| instructions << el.text.strip }

            # Tags
            
            # Image
            img_path = 'div.o-RecipeLead__m-RecipeMedia div.m-RecipeMedia__m-MediaBlock.m-MediaBlock div.m-MediaBlock__m-MediaWrap img.m-MediaBlock__a-Image.a-Image'
            img_url= doc.css(img_path).first.map { |k,v| img_url = v.match(/(food|cook).fnr.*\.jpg/).to_s if k==="src" }.compact.first
            
            # Ingredients (Materials + Amounts)
            ingredients_path = 'span.o-Ingredients__a-Ingredient--CheckboxLabel'
            doc.css(ingredients_path).each { |el| ingredients << el.text.strip unless el.text === "Deselect All" }
            
            # Description
            desc_path = 'section.o-AssetDescription'
            description = doc.css(desc_path).text.strip

            # Recipe Info
            info_path = 'span.o-RecipeInfo__a-Description'
            difficulty, total_time, active_time, servings = doc.css(info_path).map { |el| el.text.strip }.uniq
            
            @payload = { 
                :title => title, 
                :instructions => instructions, 
                :ingredients => ingredients, 
                :directions => directions,
                :image => img_url,
                :difficulty => difficulty,
                :total_time => total_time,
                :active_time => active_time,
                :servings => servings,
                :source => url
            }
        rescue => e
            set_error("Unexpected error! #{e.to_s.split("\n").first}")
        end
    end

    def set_error(error_msg)
        @error = error_msg
        puts @error
    end

    def check_url(url)
    raise "InputNeeded" if url.empty?
    raise "MustBeString" unless url.class == String
    end
        
end