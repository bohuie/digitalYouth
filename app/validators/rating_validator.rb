class RatingValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^\b[1-5]\b$/i
      record.errors[attribute] << (options[:message] || "Skill rating must be between 1 and 5")
    end
  end
end