class JobHistoriesController < ApplicationController

  before_action :authenticate_user!
  before_action :job_histories_owner, only: [:edit, :update, :destroy]

  def index
	@job_history = JobHistory.where(user_id: current_user.id)
	@user=current_user
  end

  def new
	@user=current_user
	@job_histories = JobHistory.new
         
  end

  def create
	@job_histories = JobHistory.new(job_history_params)
	if @job_histories.save
		redirect_to job_histories_path , flash: {success: "Thank you for adding to your Job History!"}
	else
		redirect_to job_histories_path , flash: {danger: "There was a problem in saving your Job History!"}
	end
  end



  def edit
	@user=current_user
	@job_history = JobHistory.find(params[:id])
  end

  def update
	@job_history = JobHistory.find(params[:id])
	if @job_history.update(job_history_params)
		flash[:success]="Thank you for updating to your Job History!"
		redirect_back_or job_histories_path
	else
		flash[:danger]="There was a problem in updating your Job History!"
		redirect_back_or job_histories_path
	end
	
  end

  def destroy
	if JobHistory.find(params[:id])
		JobHistory.find(params[:id]).destroy
		redirect_to job_histories_path , flash: {success: "Successfully Deleted."}
	else
		redirect_to job_histories_path , flash: {danger: "Your Job Did Not Delete Successfully."}
	end
  end
  
private
def job_history_params
	params.require(:job_history).permit(:user_id, :employer, :position, :start_date, :end_date, :description, :skills)

  end 

def job_histories_owner
		@job_histories = JobHistory.find(params[:id])
		
		unless @job_histories.user_id == current_user.id
			flash[:notice] = 'Access denied as you are not owner of this Job History'
			redirect_to current_user
		end
	end
end

