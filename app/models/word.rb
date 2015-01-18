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
    result = []
    if query.present?
      if query.is_a? String and query.multibyte?
        result = Word.find_based_on_char(query)
      elsif query.is_a? String
        result = Word.find_based_on_pinyin(query)
        # result += Word.find_based_on_meaning(query)
      end
    end
    return result
  end

  def self.find_based_on_char(query)
    where('traditional_char ilike :q OR simplified_char ilike :q', q: "%#{query}%").to_a.uniq { |w| w.meaning}.sort_by! { |w| w.simplified_char.length}
  end

  def self.find_based_on_pinyin(query)
    search_this = Word.find_based_on_pinyin_count(query).to_a
    split_query = query.split
    result = []
    search_this.each do |word|
      result << word if split_query.all? { |e| word.pronunciation.include? e}
    end
    return result
  end

  def self.find_based_on_pinyin_count(pinyin)
    pinyin_count = pinyin.split.count
    Word.where('pinyin_count = ?', pinyin_count)
  end

  def self.find_based_on_meaning(meaning)
    result = []
    Word.all.each do |word|
      result << word if word.meaning.include? meaning
    end
    return result
  end
end
