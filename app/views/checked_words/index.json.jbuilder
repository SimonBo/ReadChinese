json.array!(@checked_words) do |checked_word|
  json.extract! checked_word, :id, :user_id, :word_id
  json.url checked_word_url(checked_word, format: :json)
end
