String.class_eval do
  def multibyte?
    chars.count < bytes.count
  end
end