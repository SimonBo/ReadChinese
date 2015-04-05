# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reading_test do
    text
    user
    correct_answer nil
    score false
    answer_given nil
  end
end
