class WelcomeController < ApplicationController

  before_filter :logged_in, only: [:signup_jobseeker, :signup_employer]
  def index
    if user_signed_in? && current_user.has_role?(:employer)
      @new_application = PublicActivity::Activity.where(owner_id: current_user.id, is_read: false, key: "job_posting_application.create").take
      @expired_posting = JobPosting.where("user_id = ? AND close_date < ? ",current_user.id, Date.today).take
    end

    @user_bucket = user_bucket
  end

  def signup_jobseeker
    @job_seeker = User.new
    @job_seeker.build_consent
  end

  def signup_employer
    @employer = User.new
    @employer.build_consent
  end

  def lost_email

  end

  def send_lost_email
  	if ContactMailer.lost_email(params[:user][:email], params[:user][:first_name], params[:user][:last_name], params[:user][:message]).deliver_now
  		flash["notice"] = "Thank you for your request.  An administrator will look into it and contact you."
  	else
  		flash[:error] = "Your request couldn't be sent."
  	end
  	redirect_back_or root_path
  end

  helper_method :resource_name, :resource, :devise_mapping

  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  private
  def logged_in
    if user_signed_in?
      redirect_to root_path
    end
  end

  def user_bucket

    if user_signed_in?
      #Job Seeker buckets
      if current_user.has_role? :employee
        user_bucket = Hash.new

        #New User Tutorials
        if current_user.created_at > Date.today - 2.month
          # Create Projects
          if current_user.projects.count == 0
            user_bucket[:new_user_project] = "https://youtu.be/s32XxXlbLzQ"
          end
          unless current_user.answered_surveys.include? true
            user_bucket[:new_user_survey] = "https://youtu.be/1LBzhqRXbLE"
          end

          user_bucket[:new_user_compare_other] = "https://youtu.be/7RrBlU9XkFg"

          user_bucket[:new_user_compare_job] = "https://youtu.be/jAT5-2d-pSM"
        end

        # Check for unanswered surveys
        if current_user.answered_surveys.include? false && (!current_user.answered_surveys.include? true) ## if none of them have been answered
          user_bucket[:empty_survey] = SURVEYS[current_user.answered_surveys.index(false)] ## should this be ignored after a certain date?
        end

        #Old Surveys
        old_survey = current_user.responses.where("updated_at < ?", Date.today - 2.month).order("RANDOM()").first ## should this be a range? Ignore too old surveys
        if old_survey
          user_bucket[:old_survey] = SURVEYS[old_survey.survey_id]
        end

        #Most Common User Skill
        user_skill = UserSkill.group(:skill_id).order('count_id DESC').limit(1).count(:id)
        if user_skill
          user_bucket[:user_skill] = Skill.find(user_skill.keys[0]).name
        end

        #Most Common Job Posting Skill
        job_skill = JobPostingSkill.group(:skill_id).order('count_id DESC').limit(1).count(:id)
        if job_skill
          user_bucket[:job_skill] = Skill.find(job_skill.keys[0]).name
        end

        #Number of users online
        user_bucket[:online] = User.online.length

        #User References
        if current_user.unconfirmed_reference_count > 0
          user_bucket[:unconfirmed] = true
        end
        if current_user.confirmed_reference_count < LOW_REFERENCES
          user_bucket[:low_references] = true
        end

        #Job Recommendations

        #Useful Links - Increase array up to 8 size to ensure there is enough list items - Ensure at least 2 random links
        length = user_bucket.length
        links = Array.new
        links[0] = ["Tips for first job", "https://www.livecareer.com/quintessential/teen-first-job"]
        links[1] = ["Common interview questions", "http://careers.workopolis.com/advice/the-most-commonly-asked-job-interview-questions-and-how-to-answer-them/"]
        links[2] = ["Tips for a cover letter", "https://www.themuse.com/advice/how-to-write-a-cover-letter-31-tips-you-need-to-know"]
        links[3] = ["Prepare for the interview", "http://www.relaunchyourcareer.co.uk/job-interviews/six-secrets-to-doing-well-at-interview/"]
        links[4] = ["Interview tips", "https://biginterview.com/blog/2015/02/how-to-sell-yourself-in-an-interview.html"]
        if length < 6 # 8-2, ensure 2 random links
          fillers = links.sample(6-length)
        else
          fillers = links.sample(2)
        end

        fillers.each do |filler|
          user_bucket[filler[0]] = filler[1]
        end
      #Job Provider buckets
      elsif current_user.has_role? :employer
        user_bucket = Hash.new

         #New User Tutorials
        if current_user.created_at > Date.today - 2.month
          user_bucket[:new_user_survey] = ""

          user_bucket[:new_user_contact] = ""

          user_bucket[:new_user_views] = ""

          user_bucket[:new_user_compare] = ""

          user_bucket[:new_user_search] = ""
        end
        # Check for unanswered surveys
        if current_user.bio.blank?
          user_bucket[:bio] = true
        end

        #New Applicant
        unless @new_application.blank?
          user_bucket[:new_app] = @new_application
        end

        #Most Common User Skill
        user_skill = UserSkill.group(:skill_id).order('count_id DESC').limit(1).count(:id)
        if user_skill
          user_bucket[:user_skill] = Skill.find(user_skill.keys[0]).name
        end

        #Most Common Job Posting Skill
        job_skill = JobPostingSkill.group(:skill_id).order('count_id DESC').limit(1).count(:id)
        if job_skill
          user_bucket[:job_skill] = Skill.find(job_skill.keys[0]).name
        end

        #Number of users online
        user_bucket[:online] = User.online.length

        #Expired Postings
        ## Should these be seperate?
        unless @expired_posting.blank?
          if @expired_posting.job_posting_applications.blank?
            user_bucket[:expired_blank] = @expired_posting
          else
            user_bucket[:expired_with_apps] = @expired_posting
          end
        end

        #Useful Links - Increase array up to 8 size to ensure there is enough list items - Ensure at least 2 random links
        length = user_bucket.length
        links = Array.new
        links[0] = ["Tips for Millenials in the workspace", "http://www.businessknowhow.com/manage/millenials.htm"]
        links[1] = ["Millenial traits", "https://business.linkedin.com/talent-solutions/blog/2013/12/8-millennials-traits-you-should-know-about-before-you-hire-them"]
        links[2] = ["What Millenials want", "http://wallstreetinsanity.com/15-important-qualities-millennials-look-for-where-they-work/"]
        links[3] = ["Motivating employees", "https://businesscollective.com/37-ideas-for-motivating-your-employees/"]
        links[4] = ["Employee retension", "http://hr.blr.com/whitepapers/Staffing-Training/Employee-Turnover/Strategies-for-Retaining-Employees-and-Minimizing-"]
        if length < 6 # 8-2, ensure 2 random links
          fillers = links.sample(6-length)
        else
          fillers = links.sample(2)
        end

        fillers.each do |filler|
          user_bucket[filler[0]] = filler[1]
        end
      end
      return user_bucket.to_a.sample(5) ## Convert to array to use sample to grab 5 random items
    else
      return nil
    end
  end
end
