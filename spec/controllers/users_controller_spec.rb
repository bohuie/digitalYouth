require 'rails_helper'

RSpec.describe UsersController, type: :controller do 
	let(:user) { FactoryGirl.create(:user) }

	describe "GET index" do

		before do
			get :index
		end

		it "loads the users" do
			expect(assigns(:users)).to eq(User.all)
		end
	end

	describe "GET show" do

		context "it finds the user" do

			before(:each) do
				get :show, id: user.id
			end

			it "loads the specified post" do
				expect(assigns(:user)).to eq(user)
			end

			context "the user is an employee" do

				let(:project) { FactoryGirl.create(:project, user: user) }
				let(:reference) { FactoryGirl.create(:reference) }
				let(:skill) { FactoryGirl.create(:skill) }

				before do
					user.add_role(:employee)
					UserSkill.create( user_id: user.id, skill_id: skill.id, rating: 2 )
					ProjectSkill.create( project_id: project.id, skill_id: skill.id )
				end

				it "check for employee role" do
					expect(user.has_role?(:employee)).to be_truthy
				end

				it "doesn't have employer role" do
					expect(user.has_role?(:employer)).to be_falsy
				end

				it "has projects" do
					expect(user.projects).to exist
					expect(user.projects.first.title).to eq(project.title)
				end

				it "has skills" do
					expect(user.skills).to exist
					expect(user.skills.first.name).to eq(skill.name)
				end

				it "survey and references" do
					pending "this needs to be implemented"
				end

				it "has employment history" do
					pending "this needs to be implemented"
				end
			end

			context "the user is an employer" do

				let(:job_posting) { FactoryGirl.create(:job_posting, user: user) }

				before do
					user.add_role(:employer)
					job_posting
				end

				it "check for employee role" do
					expect(user.has_role?(:employee)).to be_falsy
				end

				it "doesn't have employer role" do
					expect(user.has_role?(:employer)).to be_truthy
				end

				it "has jobs" do
					expect(user.job_postings).to exist
					expect(user.job_postings.first.title).to eq(job_posting.title)
				end
			end
		end

		context "the user doesn't exist" do

			before(:each) do
				get :show, id: 1
			end

			it "should redirect to home" do
				expect(response).to redirect_to root_url	#to implement
			end
		end
	end

	describe "GET edit" do

		context "user not logged in" do
			before(:each) do
				get :edit, id: user.id
			end
			it "redirects" do
				expect(response).to redirect_to(new_user_session_path)
			end
			it "has a flash set to log in message" do
				expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
			end
		end


		context "user is logged in" do

			it "loads the page" do
				sign_in user
				get :edit, id: user.id

				expect(response).to render_template(:edit)
			end
		end

		context "other user tries to view the page" do
			let(:other_user) { FactoryGirl.create(:user2) }

			before (:each) do
				sign_in other_user

				get :edit, id: user.id
			end

			it "redirects to other_user's page" do
				expect(response).to redirect_to(user_path(other_user))
			end

			it "displays a flash warning" do
				expect(flash[:warning]).to eq("You can only make changes to your own profile.")
			end
		end
	end

	describe "POST create" do
		let(:user) { FactoryGirl.build(:user) }
		let(:new_company_name) { "Google" }
		let(:new_company_address) { "111 Other Street" }
		let(:new_company_city) { "Vancouver" }
		let(:user_attr) { {email: user.email, company_name: new_company_name, company_address: new_company_address, 
				company_city: new_company_city} }

		#not sure how to test this
		context "create user" do

			before do
				patch 'user_registration', user: user_attr
			end

			it "has the user" do
				expect(User.last.email).to eq(user.email)
			end

			it "does not have company info" do
				expect(User.last.company_name).to be_nil
				expect(User.last.company_address).to be_nil
				expect(User.last.company_city).to be_nil	
			end
		end

	end

	describe "PATCH update" do

		let(:new_company_name) { "Google" }
		let(:new_company_address) { "111 Other Street" }
		let(:new_company_city) { "Vancouver" }

		context "user not logged in" do
			before(:each) do
				patch :update, id: user.id
			end
			it "redirects" do
				expect(response).to redirect_to(new_user_session_path)
			end
			it "has a flash set to log in message" do
				expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
			end
		end	

		context "employee is logged in" do
			let(:new_email) { user.last_name.downcase+"@example.com" }
			let(:user_attr) { {email: new_email, company_name: new_company_name, company_address: new_company_address, 
				company_city: new_company_city} }

			before do
				sign_in user
				User.find(user.id).add_role :employee
				patch :update, id: user.id, user: user_attr
				@updated_user = User.find(user.id)
			end

			it "should load the page" do
				expect(response).to redirect_to(user_path(user))
			end

			it "should have the new information" do
				expect(User.last.email).to eq(new_email)
			end

			it "sets the flash to success" do
				expect(flash[:success]).to eq("User successfully updated.")
			end

			it "has nil for employer attributes" do
				expect(@updated_user.company_name).to be_nil
				expect(@updated_user.company_address).to be_nil
				expect(@updated_user.company_city).to be_nil
				expect(@updated_user.company_province).to be_nil
				expect(@updated_user.company_postal_code).to be_nil
			end
		end

		context "employer is logged in" do

			let(:new_email) { employer.last_name.downcase+"@example.com" }
			let(:user_attr) { {email: new_email, company_name: new_company_name, company_address: new_company_address, 
				company_city: new_company_city} }


			let(:employer) { FactoryGirl.create(:employer) }

			before do
				sign_in employer
				User.find(employer.id).add_role :employer
				patch :update, id: employer.id, user: user_attr
				@updated_user = User.find(employer.id)
			end

			it "has updated the employer attributes" do
				expect(@updated_user.company_name).to eq(new_company_name)
				expect(@updated_user.company_address).to eq(new_company_address)
				expect(@updated_user.company_city).to eq(new_company_city)
			end

		end

		context "logged in user is unsuccessful at updating the email" do

			let(:user_attr) { {email: user.last_name+"@example.com" }}

			before (:each) do
				sign_in user
				user_attr[:email] = nil
				User.find(user.id).add_role :employee
				patch :update, id: user.id, user: user_attr
			end

			it "should render the edit page" do
				should render_template :edit
			end

			it "should set a danger flash message" do
				expect(flash[:danger]).to eq("Please fix the errors below.")
			end
		end

		context "other user is logged in" do
			let(:other_user) { FactoryGirl.create(:user2) }
			let(:user_attr) { {email: user.last_name+"@example.com" }}

			before (:each) do
				sign_in other_user
				User.find(user.id).add_role :employee
				User.find(other_user.id).add_role :employee
				patch :update, id: user.id, user: user_attr
			end

			it "redirects to other_user's page" do
				expect(response).to redirect_to(user_path(other_user))
			end

			it "displays a flash warning" do
				expect(flash[:warning]).to eq("You can only make changes to your own profile.")
			end
		end
	end

	describe "associations" do
		let(:skill) { FactoryGirl.create(:skill) }

		before do
			sign_in user
			UserSkill.create( user_id: user.id, skill_id: skill.id )
		end

		it "should destroy associated userskills when user deleted" do
			
			user_skills = user.user_skills
			user.destroy
			expect(user_skills).to be_empty
		end
	end
end