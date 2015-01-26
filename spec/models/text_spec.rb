require 'rails_helper'

RSpec.describe Text, :type => :model do
  describe 'User added texts' do
    let(:text) { create(:text) }

    it "Is invalid without content" do
      text = build(:text, content: nil)
      text.valid?
      expect(text.errors[:content]).to include("can't be blank")
    end

    it "is invalid without a user" do
      text = build(:text, user: nil)
      text.valid?
      expect(text.errors[:user]).to include("can't be blank") 
    end

    context 'parse text after upload' do
      before do 
        traditional_chars = ['笨蛋', '水', '中國', '亭']
        simplified_chars = ['笨蛋', '水', '中国', '亭']
        meanings = ['fool, idiot', 'water, surname', 'China', 'kiosk']
        pronunciation = ['ben4 dan4', 'Shui3', 'Zhong1 guo2', 'ting']

        3.times do |i|
          Word.create(traditional_char: traditional_chars[i], simplified_char: simplified_chars[i], meaning: meanings[i], pronunciation: pronunciation[i], pinyin_count: pronunciation[i].split.count)
        end
        @text = create(:text, content: '中国笨蛋', title: '水')
      end

      it "detects which characters form words in the submitted text" do
        @text.detect_words
        water = Word.find_by_simplified_char('水')
        expect(@text.words.count).to eq 5
        expect(@text.words.values).to include water.id
      end
    end

  end
end
