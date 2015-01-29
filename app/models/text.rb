class Text < ActiveRecord::Base
  belongs_to :user
  has_many :reading_tests

  validates :content, presence: true
  validates :user, presence: true

  after_save :detect_words


  def full_text
    if self.title.empty?
      self.content
    else
      self.title + '。' + self.content
    end
  end

  def detect_words
    self.strip_text
    self.words_will_change!
    text = self.full_text
    result = {}
    text.each_char.with_index do |char, index|
      if char.is_chinese_character?
        word = Word.find_words(index, self.id)
        # puts "Checking char: #{char}"
        # puts "Result #{word}"
        result[index] = word.first.id
      end
    end
    self.update_column(:words, result)
  end

  def get_word_for_char(index)
    self.words["#{index}"]
  end

  def get_char_view_index(index)
    title_length = self.title.length
    title_length + index + 1
  end

  def strip_text
    self.title.strip!
    self.content.strip!
  end
end
