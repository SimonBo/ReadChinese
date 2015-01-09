class Word < ActiveRecord::Base

  has_many :favorite_words

  def favorite(user)
    faved_word = FavoriteWord.create(word_id: self.id, user_id: user.id)
    faved_word.save!
  end

  def self.text_search(query)
    if query.present?
      where('traditional_char ilike :q OR simplified_char ilike :q', q: "%#{query}%").to_a.uniq { |w| w.meaning}.sort_by! { |w| w.simplified_char.length}
    end
  end
end
