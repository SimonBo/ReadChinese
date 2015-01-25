class ReadingTest < ActiveRecord::Base
  belongs_to :user
  belongs_to :text

  def prepare_gap_fill_test
    self.select_random_sentence
    self.select_random_character
    self.find_matching_word
    self.type = 'gap-fill'
    save
  end

  def select_random_sentence
    text = self.text.full_text
    sentences = text.split('。')
    random_sentence = sentences.sample
    self.data['question'] = random_sentence
    sentence_index = text.index random_sentence
    self.data['question-index'] = sentence_index
    save
  end

  def select_random_character
    sentence = self.data['question']
    sentence_length = sentence.length
    random_char_index = rand(sentence_length)
    random_character = sentence[random_char_index]
    self.data['answer'] = random_character
    random_character_text_index = self.data['question-index'] + random_char_index
    self.data['answer-index'] = random_character_text_index
    save
  end

  def find_matching_word
    character_index = self.data['answer-index']
    text_id = self.text.id
    puts "Checking word at index #{character_index} in text nr #{text_id}"
    word = Word.find_words(character_index, text_id)
    self.data['answer'] = word.first.simplified_char
  end

end