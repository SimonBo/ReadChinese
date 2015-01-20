# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :text do
    content "MyText"
    source "MyString"
    user nil
  end
end
