# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :checked_word do
    user
    word
  end
end
