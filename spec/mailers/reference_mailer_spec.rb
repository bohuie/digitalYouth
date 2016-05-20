require 'rails_helper'

RSpec.describe ReferenceMailer do

  #This whole test fails
  describe 'reference email' do

    let(:user) { FactoryGirl.create(:user) }
    let(:referee) { FactoryGirl.create(:reference_email1) }
    let(:mail) { described_class.reference_email(:reference_email, user).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq("#{:referee.first_name} #{:referee.last_name} Wants a reference!")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([:referee.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['digitalyouthtest@gmail.com'])
    end

    #it 'assigns ' do
    #  expect(mail.body.encoded).to match("#{}")
    #end

    it 'assigns reference_url' do
      expect(mail.body.encoded).to match("http://digitalYouth.ca/references/new/#{:referee.reference_url}")
    end
  end
end