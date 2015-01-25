json.array!(@reading_tests) do |reading_test|
  json.extract! reading_test, :id, :user_id, :text_id, :data, :test_type
  json.url reading_test_url(reading_test, format: :json)
end
