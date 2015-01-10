require 'rails_helper'

RSpec.describe Word, :type => :model do
  describe 'User favorites a word' do
    it "adds a word id to favorite_words column if that word hasnt been favorited before" do
      word = create(:word)
      user = create(:user)
      word.favorite(user)
      expect(user.favorite_words).to include word.id
    end
  end
end
