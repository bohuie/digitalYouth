class ReferenceRedirection < ActiveRecord::Base
	include PublicActivity::Common
	belongs_to :user

	validates :reference_url, presence: true
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true
	validates :message, presence: true
end
