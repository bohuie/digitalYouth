class Project < ActiveRecord::Base

	belongs_to :user
	has_attached_file :image

	validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

	before_save :destroy_image?

	def image_delete
		@image_delete ||= "0"
	end

	def image_delete=(value)
		@image_delete = value
	end

	private
		def destroy_image?
			self.image.clear if @image_delete == "1"
		end
end
