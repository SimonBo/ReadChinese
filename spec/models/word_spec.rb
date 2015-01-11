require 'rails_helper'

RSpec.describe Word, :type => :model do
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
end
