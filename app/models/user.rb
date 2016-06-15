class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

    has_many :job_postings
    has_many :projects
    has_many :references
    has_many :reference_redirections
    has_many :responses
    
    has_many :user_skills, dependent: :destroy
    has_many :skills, through: :user_skills
end
