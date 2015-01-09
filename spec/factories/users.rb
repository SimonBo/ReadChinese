# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    pass = Faker::Internet.password(10, 20)
    password pass
    password_confirmation pass
  end
end
