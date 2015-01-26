# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :test_answer do
    association :reading_test
    association :user
    answer "MyString"
    correct false
  end
end
