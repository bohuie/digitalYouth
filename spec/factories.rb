FactoryGirl.define do
  factory :user do
    first_name     "John"
    last_name		"Smith"
    email    "john@example.com"
    password "password"
    password_confirmation "password"
  end

  factory :user2 do
    name     "Foo Bar"
    email    "foo@bar.com"
    password "password"
    password_confirmation "password"
  end
end