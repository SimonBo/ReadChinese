json.array!(@texts) do |text|
  json.extract! text, :id, :content, :source, :user_id
  json.url text_url(text, format: :json)
end
