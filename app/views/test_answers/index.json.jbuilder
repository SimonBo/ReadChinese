json.array!(@test_answers) do |test_answer|
  json.extract! test_answer, :id, :reading_test_id, :user_id, :answer, :correct
  json.url test_answer_url(test_answer, format: :json)
end
