class User < ActiveRecord::Base
  	searchkick word_start: [:company_name, :skills, :first_name, :last_name, :city, :province], callbacks: :async
  	scope :search_import, -> { includes(:roles,:users_roles) }
    after_save :user_reindex

    attr_encrypted :street_address, key: ENV["ADDRESS_KEY"]
    attr_encrypted :postal_code, key: ENV["PC_KEY"]
    attr_encrypted :unit_number, key: ENV["UNIT_KEY"]
  	
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

    has_attached_file :image,
        default_url: 'avatar-placeholder-:style.svg',
        styles: { 
            medium: { geometry: "150x150>", :processors => [:cropper] },
            small: { geometry: "100x100>", :processors => [:cropper] },
            thumb: { geometry: "45x45>", :processors => [:cropper] },
            large: { geometry: "400x400" }
        },
        convert_options: {
            medium: "-gravity center -extent 150x150",
            small: "-gravity center -extent 100x100",
            thumb: "-gravity center -extent 45x45",
            large: "-gravity center -extent 400x400"
        }
    include DeletableAttachment
    validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/svg"] }
    attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :new_email
    #after_update :reprocess_image, :if => :cropping?

    validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
    validates :province, presence: true
    validates :city, presence: true

    has_many :job_postings, dependent: :destroy
    has_many :projects, dependent: :destroy
    has_many :references, dependent: :destroy
    has_many :reference_redirections, dependent: :destroy
    has_many :responses
    has_many :job_posting_applications, dependent: :destroy
    has_many :identities
      
    has_many :user_skills, dependent: :destroy
    accepts_nested_attributes_for :user_skills
    has_many :skills, through: :user_skills

    has_one  :consent

    accepts_nested_attributes_for :consent

    def search_data
        data = Hash.new
        data[:first_name] = first_name.titleize
        data[:last_name] = last_name.titleize
        data[:company_name] = company_name.titleize if company_name
        data[:city] = city.titleize if city
        data[:province] = province.upcase if province
        data[:bio] = bio if bio
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

    def process_skills(hash) # Creates and Updates user skills, creating new skills when needed.
        hash.each do |m|
            id = m[1]["id"]
            if m[1]["_destroy"] == "true"
                UserSkill.find(id).destroy if !id.blank?
            elsif m[1]["_destroy"] == "false" || m[1]["_destroy"].empty?
                if m[1]["skill"].nil?
                    skill_name = m[1]["skill_attributes"]["name"].titleize
                else
                    skill_name = m[1]["skill"].titleize
                end
                skill = Skill.find_by(name: skill_name)
                if skill.nil?
                    skill = Skill.new(name: skill_name)
                    return false if !skill.save
                end
                skill_id = skill.id
                question_id = m[1]["question_id"]

                if id.blank?
                    user_skill = UserSkill.new(skill_id: skill_id, question_id: question_id, user_id: self.id)
                    return false if !user_skill.save
                else
                    user_skill = UserSkill.find(id)
                    return false if !user_skill.update(skill_id: skill_id, question_id: question_id, user_id: self.id)
                end
            end
        end
        return true
    end

    def cropping?
        !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
    end

    def image_geometry(style = :original)
        @geometry ||= {}
        @geometry[style] ||= Paperclip::Geometry.from_file(image.path(style))
    end

    def reprocess_image
        image.reprocess!
    end
end