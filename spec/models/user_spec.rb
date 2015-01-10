require 'rails_helper'

RSpec.describe User, :type => :model do
  it "returns true if user favorited the word" do
    word = create(:word)
    user = create(:user)
    user.favorite_words << word.id
    expect(user.faved_word?(word)).to eq true
  end
end
