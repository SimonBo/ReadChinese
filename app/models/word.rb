class Word < ActiveRecord::Base

  def self.find_words(word_index, text)
    text_to_check = Text.find(text)
    text = text_to_check.full_text
    word_index = word_index.to_i
    char_index = word_index.to_i
    char = text[char_index]
    words_containing_char = Word.where('simplified_char like ?', "%#{char}%")
    simplified_chars = words_containing_char.map { |w| w.simplified_char }
    matches =[char]
    # puts "Matches array: #{matches}"

    check_from = 0
    check_from = word_index - 10 if word_index > 10 
    # puts "Gonna check text from index: #{check_from}"

    check_to = -1
    check_to = word_index +10 if text.length - word_index > 10
    # puts "Gonna check to index: #{check_to}"

    (check_from..char_index).each_with_index do |iteration, index|
      # puts "Iteration: #{iteration}, index #{index}"
      unless text[check_from+index].nil?
        text[check_from+index..check_to].each_char.with_index do |word, word_index|
          checked_word = text[check_from+index..check_from+index+ word_index]
            # puts "Checking #{checked_word} at index #{check_from+iteration..check_from+iteration+index}"
            unless checked_word.nil? or checked_word.blank? or !checked_word.include? char
              matches << checked_word if simplified_chars.include? checked_word and !matches.include? checked_word
            end
          end
        end
      end

      final_match = matches.group_by(&:size).max.last[0]
    # puts final_match
    Word.where('simplified_char = ?', final_match)
  end

  def mark_as_checked(user)
    word = user.checked_words.find_or_create_by(word_id: self.id)
    word.counter += 1
    word.save
  end
  
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
      if query.is_a? String and query.is_chinese_character?
        Word.find_based_on_char(query)
      elsif query.is_a? String and query.is_pinyin?
        Word.find_based_on_pinyin(query)
      elsif query.is_a? String
        Word.find_based_on_meaning(query)
      end
    end
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
      word_meanings = word.meaning.gsub(/,/, ' ').gsub(/[^0-9a-z ]/i, '')
      .split
      result << word if word_meanings.include? meaning
    end
    return result
  end
end
