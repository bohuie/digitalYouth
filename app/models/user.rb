class User < ActiveRecord::Base
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

    rolify
    # Include default devise modules. Others available are:
    # :timeoutable and :omniauthable, :lockable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :confirmable

    has_many :job_postings
    has_many :projects
    has_many :references
    has_many :reference_redirections
    has_many :responses
    has_many :job_posting_applications
      
    has_many :user_skills, dependent: :destroy
    has_many :skills, through: :user_skills
end