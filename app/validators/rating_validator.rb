class RatingValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value = /^\b[0-#{max_rating}]\b$/i
      record.errors[attribute] << (options[:message] || "Skill rating must be between 0 and "+max_rating)
    end
  end
end