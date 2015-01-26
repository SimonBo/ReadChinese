require 'rails_helper'

RSpec.describe String, :type => :model do
  describe "detect if text is chinese" do
    it "is true if the string is a chinese character" do
      string = '笨'
      expect(string.is_chinese_character?).to eq true
    end

    it "returns false if the string is not a chinese character" do
      string = 'a'
      expect(string.is_chinese_character?).to eq false
    end

    it "returns false if the string has non-alphabetic characters inputted with a chinese keyboard" do
      string = '。'
      expect(string.is_chinese_character?).to eq false
    end
  end
end
