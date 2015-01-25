class Text < ActiveRecord::Base
  belongs_to :user

  def full_text
    if self.title = ''
      self.content
    else
      self.title + '。' + self.content
    end
  end
end
