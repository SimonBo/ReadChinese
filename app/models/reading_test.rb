class ReadingTest < ActiveRecord::Base
  belongs_to :text
  belongs_to :user
  belongs_to :correct_answer, class_name: 'Word'
  belongs_to :answer_given, class_name: 'Word'

  def select_random_sentence_and_word
    random_sentence = self.text.select_random_sentence
    random_word = random_sentence.select_random_word
  end
end
