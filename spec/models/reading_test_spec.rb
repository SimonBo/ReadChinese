require 'rails_helper'

RSpec.describe ReadingTest, :type => :model do
  describe 'selects a random word from given text to form a gap fill test' do
    @text = FactoryGirl.create(:text, content: '中国笨蛋', title: '水')
    test = FactoryGirl.create(:reading_test, text: @text)
    test.select_random_sentence_and_word
    expect(test.correct_answer).to eq '中国' or '笨蛋' or '水'
  end
end