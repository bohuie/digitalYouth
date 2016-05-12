# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[:admin, :employee, :employer].each do |role|
  Role.create({ name: role })
end

user = User.create(first_name: 'John', last_name: 'Doe', email: 'john@doe.com', password: 'password', password_confirmation: 'password')
user.add_role :employee

user = User.create(first_name: 'Foo', last_name: 'Bar', email: 'foo@bar.com', password: 'password', password_confirmation: 'password', 
	company_name: 'Google', company_address: '123 Fake Street', company_city: 'Kelowna', company_province: 'BC', company_postal_code: 'V1V 1V1')
user.add_role :employer

JobPosting.create(title: 'Social Media Manager', description: 'Handling our Facebook and Twitter account, posting messages, and responding to clients.', open_date: '2016-01-01', close_date: '2016-04-01', user_id: user.id)