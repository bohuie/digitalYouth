class User < ActiveRecord::Base
  include PublicActivity::Model
  tracked only: :create, owner: ->(controller,model) {model && model.itself}
  searchkick

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
