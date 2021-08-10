class MealsValidator < ActiveModel::Validator
    def validate(record)
        if options[:fields].any? do |field| 
            if record[field].nil? || record[field].length < 3 
                record.errors.add :errors, "There must be at least 3 #{field.capitalize}" 
            end
           end
        end
    end
end