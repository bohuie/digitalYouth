class ApplicationController < ActionController::Base
  include NotificationsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :notification_bar
  after_action :store_location
  around_filter :catch_not_found
  after_filter :ahoy_track, :user_activity

  def notification_bar
    if user_signed_in?
      @notif_unseen = display_notif_unseen(current_user.id)
      @notif_count_style = style_notif_count(@notif_unseen)
    end
  end

  def after_sign_in_path_for(resource)
  	root_path
  end

  # Redirect to stored location (or specified)
  # Usage:
  # redirect_back_or // This redirects to the last visited page.
  #                   // If there is no page and no specified path, it will go to root_path
  # redirect_back_or current_user_path // This redirects to the current_user page
  def redirect_back_or (specified =nil)
    if specified.nil? && session[:forwarding_url].nil?
      redirect_to root_path
    elsif specified.nil?
       redirect_to(session[:forwarding_url])
    else
      redirect_to (specified)
    end
    session.delete(:forwarding_url)
  end

  # Stores the last URL visited.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def clear_nav_tab
    if session.key?(:nav_tab)
      session.delete(:nav_tab)
    end
  end

  private

  def user_bucket(amount = 5)

    if user_signed_in?
      #Job Seeker buckets
      if current_user.has_role? :employee
        user_bucket = Array.new

        #New User Tutorials
        # Under 2 months, increase weighting to 4
        # 2 - 4 months, weighting at 3
        # 4 - 6 months, weighting at 2
        # 6 - 12 months, weighting at 1
        # After 12 months, none

        if current_user.created_at >= Date.today - 2.month
          weight = 4
        elsif current_user.created_at < Date.today - 2.month && current_user.created_at >= Date.today - 4.month
          weight = 3
        elsif current_user.created_at < Date.today - 4.month && current_user.created_at >= Date.today - 6.month
          weight = 2
        elsif current_user.created_at < Date.today - 6.month && current_user.created_at >= Date.today - 12.month
          weight = 1
        else
          weight = 0
        end

        ind = 0
        while (ind < weight)
          # Create Projects
          #if current_user.projects.count == 0
            user_bucket << [:new_user_project, "https://youtu.be/VyKTGBCtUks?list=PL9tO6C1pzlUmHp3JDoTYetpWCV1vCXRwn"]
          #end
          #unless current_user.answered_surveys.include? true
            user_bucket << [ :new_user_survey, "https://youtu.be/zaiOkJSDwkM?list=PL9tO6C1pzlUmHp3JDoTYetpWCV1vCXRwn"]
          #end

          user_bucket << [:new_user_compare_other, "https://youtu.be/toecYbprHC0?list=PL9tO6C1pzlUmHp3JDoTYetpWCV1vCXRwn"]

          user_bucket << [:new_user_compare_job, "https://youtu.be/RhZtlkxpsis?list=PL9tO6C1pzlUmHp3JDoTYetpWCV1vCXRwn"]
          ind += 1
        end

        # Check for unanswered surveys
        if current_user.answered_surveys.include? false && (!current_user.answered_surveys.include? true) ## if none of them have been answered
          user_bucket << [:empty_survey, SURVEYS[current_user.answered_surveys.index(false) + 1]] ## Account for off-by-one index error due to Array(0) vs DB(1) indexing
        end

        #Most Common User Skill
        user_skill = UserSkill.group(:skill_id).order('count_id DESC').limit(1).count(:id)
        if user_skill
          user_bucket << [:user_skill, Skill.find(user_skill.keys[0]).name]
        end

        #Most Common Job Posting Skill
        job_skill = JobPostingSkill.group(:skill_id).order('count_id DESC').limit(1).count(:id)
        if job_skill
          #user_bucket << [:job_skill, Skill.find(job_skill.keys[0]).name]
        end

        #Number of users online ##change to total number of JS and JP
        #user_bucket[:online] = User.online.length

        #User References
        if current_user.unconfirmed_reference_count > 0
          user_bucket << [:unconfirmed, true]
        end
        if current_user.confirmed_reference_count < LOW_REFERENCES
          user_bucket << [:low_references, true]
        end

        #Job Recommendations

        #Useful Links - Increase array up to 8 size to ensure there is enough list items - Ensure at least 2 random links
        length = user_bucket.length
        links = Array.new
        links[0] = ["Recommended Reading - Tips for first job", "https://www.livecareer.com/quintessential/teen-first-job"]
        links[1] = ["Recommended Reading - Common interview questions", "http://careers.workopolis.com/advice/the-most-commonly-asked-job-interview-questions-and-how-to-answer-them/"]
        links[2] = ["Recommended Reading - Tips for a cover letter", "https://www.themuse.com/advice/how-to-write-a-cover-letter-31-tips-you-need-to-know"]
        links[3] = ["Recommended Reading - Prepare for the interview", "http://www.relaunchyourcareer.co.uk/job-interviews/six-secrets-to-doing-well-at-interview/"]
        links[4] = ["Recommended Reading - Interview tips", "https://biginterview.com/blog/2015/02/how-to-sell-yourself-in-an-interview.html"]
        if length < 6 # 8-2, ensure 2 random links
          fillers = links.sample(6-length)
        else
          fillers = links.sample(2)
        end

        fillers.each do |filler|
          user_bucket << [filler[0], filler[1]]
        end
      #Job Provider buckets
      elsif current_user.has_role? :employer
        user_bucket = Array.new

         #New User Tutorials
        if current_user.created_at >= Date.today - 2.month
          weight = 4
        elsif current_user.created_at < Date.today - 2.month && current_user.created_at >= Date.today - 4.month
          weight = 3
        elsif current_user.created_at < Date.today - 4.month && current_user.created_at >= Date.today - 6.month
          weight = 2
        elsif current_user.created_at < Date.today - 6.month && current_user.created_at >= Date.today - 12.month
          weight = 1
        else
          weight = 0
        end

        ind = 0
        while (ind < weight)
          user_bucket << [:new_user_survey, "https://youtu.be/2ZpXlirkGAI?list=PL9tO6C1pzlUmUIFmkFTm_PzEC3WTj--Qc"]

          user_bucket << [:new_user_contact, "https://youtu.be/dvM28EJREoQ?list=PL9tO6C1pzlUmUIFmkFTm_PzEC3WTj--Qc"]

          user_bucket << [:new_user_views, "https://youtu.be/Og3W2xFB0gE?list=PL9tO6C1pzlUmUIFmkFTm_PzEC3WTj--Qc"]

          user_bucket << [:new_user_compare, "https://youtu.be/4HLlBQP5kN8?list=PL9tO6C1pzlUmUIFmkFTm_PzEC3WTj--Qc"]

          user_bucket << [:new_user_search, "https://youtu.be/qhrh-IXDnn4?list=PL9tO6C1pzlUmUIFmkFTm_PzEC3WTj--Qc"]

          ind += 1
        end

        # Check for unanswered surveys
        if current_user.bio.blank?
          user_bucket << [:bio, true]
        end

        #New Applicant
        unless @new_application.blank?
          user_bucket << [:new_app, @new_application]
        end

        #Most Common User Skill
        user_skill = UserSkill.group(:skill_id).order('count_id DESC').limit(1).count(:id)
        if user_skill
          user_bucket << [:user_skill, Skill.find(user_skill.keys[0]).name]
        end

        #Most Common Job Posting Skill
        job_skill = JobPostingSkill.group(:skill_id).order('count_id DESC').limit(1).count(:id)
        if job_skill
          #user_bucket << [:job_skill, Skill.find(job_skill.keys[0]).name]
        end

        #Number of users online
        #user_bucket[:online] = User.online.length

        #Expired Postings
        ## Should these be seperate?
        unless @expired_posting.blank?
          if @expired_posting.job_posting_applications.blank?
            user_bucket << [:expired_blank, @expired_posting]
          else
            user_bucket << [:expired_with_apps, @expired_posting]
          end
        end

        #Useful Links - Increase array up to 8 size to ensure there is enough list items - Ensure at least 2 random links
        length = user_bucket.length
        links = Array.new
        links[0] = ["Recommended Reading - Tips for Millenials in the workspace", "http://www.businessknowhow.com/manage/millenials.htm"]
        links[1] = ["Recommended Reading - Millenial traits", "https://business.linkedin.com/talent-solutions/blog/2013/12/8-millennials-traits-you-should-know-about-before-you-hire-them"]
        links[2] = ["Recommended Reading - What Millenials want", "http://wallstreetinsanity.com/15-important-qualities-millennials-look-for-where-they-work/"]
        links[3] = ["Recommended Reading - Motivating employees", "https://businesscollective.com/37-ideas-for-motivating-your-employees/"]
        links[4] = ["Recommended Reading - Employee retension", "http://hr.blr.com/whitepapers/Staffing-Training/Employee-Turnover/Strategies-for-Retaining-Employees-and-Minimizing-"]
        if length < 6 # 8-2, ensure 2 random links
          fillers = links.sample(6-length)
        else
          fillers = links.sample(2)
        end

        fillers.each do |filler|
          user_bucket << [filler[0], filler[1]]
        end
      end

      items = Array.new
      while( items.length < amount)
        item = user_bucket.sample
        unless items.include?(item)
          items << item
        end
      end
      return items
    else
      return nil
    end
  end

  def catch_not_found
    yield
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "There was an error with your search.  Please try again later, or contact an administrator."
      redirect_back_or root_url
  end

  def user_activity
    current_user.try :touch
  end

protected
  def ahoy_track
      ahoy.track_visit if current_visit == nil
  end
end