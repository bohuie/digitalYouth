class User < ActiveRecord::Base
  	searchkick callbacks: :async
  	scope :search_import, -> { includes(:roles,:users_roles) }
    after_save :user_reindex

  	
    include PublicActivity::Model

    TEMP_EMAIL_PREFIX = 'change@me'
    TEMP_EMAIL_REGEX = /\Achange@me/

    tracked only: :create, owner: ->(controller,model) {model && model.itself}

    nilify_blanks

	rolify
	# Include default devise modules. Others available are:
	# :timeoutable and :omniauthable, :lockable, :rememberable
	devise :database_authenticatable, :registerable,
	       :recoverable, :trackable, :validatable, :confirmable, :omniauthable

    has_attached_file :image, default_url: 'avatar-placeholder.svg'
    include DeletableAttachment
    validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/svg"] }

    validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

    has_many :job_postings
    has_many :projects
    has_many :references
    has_many :reference_redirections
    has_many :responses
    has_many :job_posting_applications
    has_many :identities
      
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
        data[:skills] = self.skills.pluck(:name)
        return data
	end

    def user_reindex
        User.reindex if !Rails.env.test?
    end

    def self.find_for_oauth(auth, signed_in_resource = nil)

        # Get the identity and user if they exist
        identity = Identity.find_for_oauth(auth)

        # If a signed_in_resource is provided it always overrides the existing user
        # to prevent the identity being locked with accidentally created accounts.
        # Note that this may leave zombie accounts (with no associated identity) which
        # can be cleaned up at a later date.
        user = signed_in_resource ? signed_in_resource : identity.user

        # Create the user if needed
        if user.nil?

            # Get the existing user by email if the provider gives us a verified email.
            # If no verified email was provided we ask the user to login or signup
            email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
            email = auth.info.email if email_is_verified
            user = User.where(:email => email).first if email
        end

        # Associate the identity with the user if needed
        if identity.user != user
            identity.user = user
            identity.save!
            end
        user
    end

    def email_verified?
        self.email && self.email !~ TEMP_EMAIL_REGEX
    end
end