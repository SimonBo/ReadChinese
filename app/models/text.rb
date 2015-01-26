class Text < ActiveRecord::Base
  belongs_to :user
  has_many :reading_tests

  def full_text
    if self.title = ''
      self.content
    else
      self.title + '。' + self.content
    end
  end
end
