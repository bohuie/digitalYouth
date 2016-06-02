require 'rails_helper'

RSpec.describe ResponsesController, type: :controller do

	describe "POST create" do
		let(:user) { FactoryGirl.create(:user) }
		let(:response1) { FactoryGirl.build(:response1) }
		#The following is needed to remap the arrays into a hash like it is when the form submits
		let(:scores) { {"0" => response1.scores[0], "1" => response1.scores[1], "2" => response1.scores[2], "3" => response1.scores[3]} }
		let(:questions) { {"0" => response1.question_ids[0], "1" => response1.question_ids[1], "2" => response1.question_ids[2], "3" => response1.question_ids[3]} }
		let(:response_attr) { {survey_id: 1, scores: scores , question_ids: questions } }

		it "redirects when not logged in" do
			post :create
			expect(response).to redirect_to(new_user_session_path)
		end

		it "redirects if the user is not an employee" do
			sign_in user
			post :update, response: response_attr
			expect(response).to redirect_to(user_path(user))
		end

		context "user is logged in" do
			before(:each) do
				user.add_role(:employee)
				sign_in user
				@count = Response.count
				post :create, response: response_attr
			end

			it "increases the count by one" do
				expect(Response.count).to eq(@count+1)
			end

			it "has the new response in it" do
				expect(Response.last.user_id).to eq(user.id)
				expect(Response.last.scores).to eq(response1.scores)
				expect(Response.last.survey_id).to eq(response1.survey_id)
				expect(Response.last.question_ids).to eq(response1.question_ids)
			end

			it  "redirects to user page" do
				expect(response).to redirect_to(user_path(user))
			end
		end
	end


	describe "PATCH update" do
		let(:user) { FactoryGirl.create(:user) }
		let(:response1) { FactoryGirl.create(:response1) }
		let(:response2) { FactoryGirl.build(:response2) }
		#The following is needed to remap the arrays into a hash like it is when the form submits
		let(:scores) { {"0" => response2.scores[0], "1" => response2.scores[1], "2" => response2.scores[2], "3" => response2.scores[3]} }
		let(:questions) { {"0" => response2.question_ids[0], "1" => response2.question_ids[1], "2" => response2.question_ids[2], "3" => response2.question_ids[3]} }
		let(:response_attr) { {survey_id: 1, scores: scores , question_ids: questions } }

		it "redirects when not logged in" do
			patch :update
			expect(response).to redirect_to(new_user_session_path)
		end

		it "redirects if the user is not an employee" do
			sign_in user
			patch :update, response: response_attr
			expect(response).to redirect_to(user_path(user))
		end

		context "employee user is logged in" do
			before(:each) do
				user.responses << response1
				user.add_role(:employee)
				sign_in user
				patch :update, response: response_attr
			end

			it "has the new information" do
				expect(Response.last.user_id).to eq(user.id)
				expect(Response.last.scores).to eq(response2.scores)
				expect(Response.last.survey_id).to eq(response2.survey_id)
				expect(Response.last.question_ids).to eq(response2.question_ids)
			end

			it "redirects to user page" do
				expect(response).to redirect_to(user_path(user))
			end
		end
	end
end
