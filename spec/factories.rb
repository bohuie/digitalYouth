FactoryGirl.define do
  factory :user do
    first_name	"John"
    last_name	"Smith"
    email		"john@example.com"
    password	"password"
    password_confirmation	"password"
  end

  factory :user2, class: User do
    first_name	"Foo"
    last_name	"Bar"
    email		"foo@example.com"
    password	"password"
    password_confirmation	"password"
  end

  factory :project do
  	title		"A project title"
  	description	"Description of the project"
  end
end