# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :text do
    title "MyText"
    content "MyText"
    source "MyString"
    user
  end
end
