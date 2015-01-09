class Word < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search, against: [:traditional_char, :simplified_char]

  def self.text_search(query)
    if query.present?
      search(query)
    else
      where(nil)
    end
  end
end
