class Word < ActiveRecord::Base

  def favorite(user)
    user.favorite_words_will_change!
    user.favorite_words << self.id
    user.save!
  end

  def self.text_search(query)
    if query.present?
      where('traditional_char ilike :q OR simplified_char ilike :q', q: "%#{query}%").to_a.uniq { |w| w.meaning}.sort_by! { |w| w.simplified_char.length}
    end
  end
end
