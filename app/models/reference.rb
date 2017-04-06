class Reference < ActiveRecord::Base
	include PublicActivity::Model
	tracked only: :create, owner: ->(controller,model) {model && model.user}

	belongs_to :referee, :class_name => "User"
	belongs_to :user

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :company, presence: true
	validates :position, presence: true
	validates :reference_body, presence: true



	before_destroy :destroy_notification
private
	def destroy_notification
		PublicActivity::Activity.find_by(trackable_id: self.id, trackable_type: "Reference").destroy
	end
end
