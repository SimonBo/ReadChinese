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
end
