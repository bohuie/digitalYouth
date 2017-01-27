# encoding: utf-8
class String
    def titleize
        self.capitalize!  # capitalize the first word in case it is part of the no words array
        words_no_cap = ["and", "or", "the", "over", "to", "the", "a", "but"]
        words_all_cap = ["html"]
        phrase = self.split(" ").map {|word| 
            if words_no_cap.include?(word) 
                word
            elsif words_all_cap.include?(word.downcase)
                word.upcase
            else
                word.capitalize
            end
        }.join(" ") # I replaced the "end" in "end.join(" ") with "}" because it wasn't working in Ruby 2.1.1
    self.replace(phrase)  # returns the phrase with all the excluded words
    end
end
# encoding: utf-8
#class String
#  def titleize(options = {})
#    exclusions = options[:exclude]

#    return ActiveSupport::Inflector.titleize(self) unless exclusions.present?
#    self.underscore.humanize.gsub(/\b(?<!['’`])(?!(#{exclusions.join('|')})\b)[a-z]/) { $&.capitalize }
#  end
#end