class Text < ActiveRecord::Base
  belongs_to :user
  has_many :reading_tests

  validates :content, presence: true
  validates :user, presence: true


  def full_text
    if self.title.empty?
      self.content
    else
      self.title + '。' + self.content
    end
  end

  def detect_words
    text = self.full_text
    text.each_char.with_index do |char, index|
      if char.is_chinese_character?
        word = Word.find_words(index, self.id)
        self.words[index] = word.first.id
      end
    end
    save
  end

  def get_word_for_char(index)
    self.words[index]
  end

  def get_char_view_index(index)
    title_length = self.title.length
    title_length + index + 1
  end
end
