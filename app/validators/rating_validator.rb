class RatingValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value = /^\b[0-#{ENV['MAX_RATING']}]\b$/i
      record.errors[attribute] << (options[:message] || "Skill rating must be between 0 and "+ENV['MAX_RATING'])
    end
  end
end