require 'rails_helper'

RSpec.describe ReadingTest, :type => :model do
  describe "Generate test" do
    context "gap-fill test" do
      before do 
        traditional_chars = ['笨蛋', '水', '中國', '亭']
        simplified_chars = ['笨蛋', '水', '中国', '亭']
        meanings = ['fool, idiot', 'water, surname', 'China', 'kiosk']
        pronunciation = ['ben4 dan4', 'Shui3', 'Zhong1 guo2', 'ting']

        3.times do |i|
          Word.create(traditional_char: traditional_chars[i], simplified_char: simplified_chars[i], meaning: meanings[i], pronunciation: pronunciation[i], pinyin_count: pronunciation[i].split.count)
        end

        @short_text = create(:text, content: '中国笨蛋', title: '')
        @short_text_test = create(:reading_test, text: @short_text)
        @text = create(:text, content: "我是懒猪。你是铁公鸡。", title: "猪和公鸡")
        @test = create(:reading_test, text: @text)

      end

      it "picks a random sentence from given text" do
        @test.select_random_sentence
        random_sentence = @test.data['question']
        possible_sentences = ["我是懒猪", "你是铁公鸡", "猪和公鸡"]
        expect(possible_sentences).to include random_sentence
      end

      it "saves the random senetence index" do
        @short_text_test.select_random_sentence
        puts @short_text_test.text.full_text
        expect(@short_text_test.data['question-index']).to eq 0
      end

      it "picks a random chinese character from the random sentence" do
        text = create(:text, content: "。。。我';][", title: "dupa")
        test = create(:reading_test, text: text)
        test.select_random_sentence
        test.select_random_character
        random_character = test.data['answer']
        possible_characters = %w(我)
        expect(possible_characters).to include random_character
      end

      it "saves the random character's index" do
        @short_text_test.select_random_sentence
        @short_text_test.select_random_character
        puts @short_text_test.data['answer']
        expect(0..3).to cover(@short_text_test.data['answer-index'])
      end

      it "finds the word which the random character is the part of" do
        @short_text_test.prepare_gap_fill_test
        matching_word = @short_text_test.data['answer']
        possible_matches = %w(中国 笨蛋)
        expect(possible_matches).to include matching_word
      end

      it "replaces the found word in the selected sentence with 3 dots" do
        @short_text_test.prepare_gap_fill_test
        sentence_to_prepare = @short_text_test.data['question']
        possible_test_sentences = %w(...笨蛋 中国...)
        expect(possible_test_sentences).to include sentence_to_prepare
      end
    end
  end
end
