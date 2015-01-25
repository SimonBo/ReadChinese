class ReadingTest < ActiveRecord::Base
  belongs_to :user
  belongs_to :text
end
