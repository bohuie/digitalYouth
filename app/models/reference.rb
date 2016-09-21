class Reference < ActiveRecord::Base
	include PublicActivity::Model
	tracked only: :create, owner: ->(controller,model) {model && model.user}

	belongs_to :referee, :class_name => "User"
	belongs_to :user

	before_save do
  		self.email = self.email.downcase
	end

	before_destroy :destroy_notification
private
	def destroy_notification
		PublicActivity::Activity.find_by(trackable_id: self.id, trackable_type: "Reference").destroy
	end
end
