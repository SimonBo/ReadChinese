json.array!(@favorite_words) do |favorite_word|
  json.extract! favorite_word, :id, :user_id, :word_id
  json.url favorite_word_url(favorite_word, format: :json)
end
