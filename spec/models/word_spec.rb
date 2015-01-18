require 'rails_helper'

RSpec.describe Word, :type => :model do
  describe 'User searches for a word' do
    before do 
      traditional_chars = ['笨蛋', '水', '中國', '亭']
      simplified_chars = ['笨蛋', '水', '中国', '亭']
      meanings = ['/fool/idiot/', '/water/', '/China/', '/kiosk/']
      pronunciation = ['ben4 dan4', 'Shui3', 'Zhong1 guo2', 'ting']

      3.times do |i|
        Word.create(traditional_char: traditional_chars[i], simplified_char: simplified_chars[i], meaning: meanings[i], pronunciation: pronunciation[i], pinyin_count: pronunciation[i].split.count)
      end
      @idiot = Word.find_by_simplified_char('笨蛋')
      @water = Word.find_by_simplified_char('水')
      @user = create(:user)
    end

    it "returns true if the user's input is contains pinyin and not meaning words" do
      input = 'ben dan'
      expect(input.is_pinyin?).to eq true
    end

    context 'search by simplified characters' do
      it "returns true if given characters are chinese characters" do
        @input = '笨蛋'
        expect(@input.multibyte?).to eq true
      end
      it "returns a list of words that contain characters from users input" do
        @input = '笨蛋'        
        expect(Word.text_search(@input)).to include @idiot
      end

      it "doesn't return words that dont contain characters form users input" do
        @input = '笨蛋' 
        expect(Word.text_search(@input)).not_to include @water
      end
    end

    context 'search by pin yin (no tones)' do
      before do
        @input = 'ben dan'
      end
      it "returns an array of words with the same number of pinyin chunks" do
        expect(Word.find_based_on_pinyin_count(@input)).to include @idiot and @water
      end

      it "returns a list of words that have the same pin yin as the pin yin from users input" do
        expect(Word.find_based_on_pinyin(@input).count).to eq 1
        expect(Word.find_based_on_pinyin(@input)).to include @idiot
      end
    end

    context 'search by meaning' do
      before do
        @input = 'water'
      end

      it "returns an array of words that match the meaning input" do
        expect(Word.find_based_on_meaning(@input)).to include @water
        expect(Word.find_based_on_meaning(@input).count).to eq 1
      end
    end

  end

  describe 'User favorites a word' do
    before do
      @word = create(:word)
      @user = create(:user)
    end

    it "adds a word id to favorite_words column if that word hasnt been favorited before" do
      @word.favorite(@user)
      expect(@user.favorite_words).to include @word.id
    end

    it "does not add the word id if its already in the array" do
      @word.favorite(@user)
      @word.favorite(@user)
      expect(@user.favorite_words.count).to eq 1
    end
  end

  describe 'User unfavorites a word' do
    before do
      @word = create(:word)
      @user = create(:user)
      @user.favorite_words << @word.id
    end

    it "deletes the favorite word id from users favorite_words" do
      @word.unfavorite(@user)
      expect(@user.favorite_words).not_to include @word.id
    end
  end
end
