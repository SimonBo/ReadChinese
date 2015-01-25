class Text < ActiveRecord::Base
  belongs_to :user

  def full_text
    self.title + '。' + self.content
  end
end
