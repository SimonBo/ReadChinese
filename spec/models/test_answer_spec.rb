require 'rails_helper'

RSpec.describe TestAnswer, :type => :model do
  describe "Answer test  question" do
    context 'answer by typing' do
      let(:user) { create(:user) }
      let(:test) { create(:reading_test, data: {"answer"=>"指挥"}) }

      it "is invalid without an  answer" do
        answer = TestAnswer.new(answer: nil)
        answer.valid?
        expect(answer.errors[:answer]).to include("can't be blank")
      end

      it "marks the answer as correct if it matches the data[answer] of the related reading_test" do
        answer = create(:test_answer, user: user, reading_test: test, answer: '指挥')
        answer.check_answer
        expect(answer.correct).to eq true
      end

      it "marks the answer as incorrect if it doesnt match the data[answer] of the related reading_test" do
        answer = create(:test_answer, user: user, reading_test: test, answer: '笨蛋')
        answer.check_answer
        expect(answer.correct).to eq false
      end
    end
  end
end
