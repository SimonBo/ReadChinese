class Word < ActiveRecord::Base

  def favorite(user)
    unless user.favorite_words.include? self.id
      user.favorite_words_will_change!
      user.favorite_words << self.id
      user.save!
    end
  end

  def unfavorite(user)
    user.favorite_words_will_change!
    user.favorite_words.delete(self.id)
    user.save!
  end

  def self.text_search(query)
    if query.present?
      if query.is_a? String and query.multibyte?
        Word.find_based_on_char(query)
      elsif query.is_a? String
        Word.find_based_on_pinyin(query)
      end
    end
  end

  def self.find_based_on_char(query)
    where('traditional_char ilike :q OR simplified_char ilike :q', q: "%#{query}%").to_a.uniq { |w| w.meaning}.sort_by! { |w| w.simplified_char.length}
  end

  def self.find_based_on_pinyin(query)
    input = query.split
    result = []
    Word.all.each do |word|
      if  input.all? {|chunk| word.pronunciation.include? chunk}
        result << word
      end
    end
    return result
  end
end
