class TestAnswer < ActiveRecord::Base
  belongs_to :reading_test
  belongs_to :user

  validates :answer, presence: true
  validates :user_id, presence: true
  validates :reading_test_id, presence: true

  def check_answer
    test = self.reading_test
    answer = self.answer
    if answer == test.data['answer']
      self.correct = true
    else
      self.correct = false
    end
    save
  end

  def original_task_sentence
    self.reading_test.data['question']   
  end
end

