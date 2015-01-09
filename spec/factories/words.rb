# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :word do
    traditional_char "MyString"
    simplified_char "MyString"
    meaning "MyString"
    pronunciation "MyString"
  end
end
