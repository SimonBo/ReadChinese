json.array!(@words) do |word|
  json.extract! word, :id, :traditional_char, :simplified_char, :meaning, :pronunciation
  json.url word_url(word, format: :json)
end
