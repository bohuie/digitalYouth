class User < ActiveRecord::Base
  	searchkick
  	scope :search_import, -> { includes(:roles,:users_roles) }
  	
    include PublicActivity::Model
    tracked only: :create, owner: ->(controller,model) {model && model.itself}

	rolify
	# Include default devise modules. Others available are:
	# :timeoutable and :omniauthable, :lockable, :rememberable
	devise :database_authenticatable, :registerable,
	       :recoverable, :trackable, :validatable, :confirmable

    has_attached_file :image, default_url: 'avatar-placeholder.svg'
    include DeletableAttachment
    validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/svg"] }

    has_many :job_postings
    has_many :projects
    has_many :references
    has_many :reference_redirections
    has_many :responses
    has_many :job_posting_applications
      
    has_many :user_skills, dependent: :destroy
    has_many :skills, through: :user_skills

    def search_data
        data = Hash.new
        data[:first_name] = first_name
        data[:last_name] = last_name
        data[:company_name] = company_name
        data[:company_city] = company_city
        data[:company_address] = company_address
        data[:company_province] = company_province
        data[:role] = self.roles.first.name if !self.roles.first.nil?
        return data
	end
end