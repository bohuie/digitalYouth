class Prompt < ActiveRecord::Base
	belongs_to :question

	validates :prompt, presence: true 
end
