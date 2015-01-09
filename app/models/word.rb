class Word < ActiveRecord::Base


  def self.text_search(query)
    if query.present?
      where('traditional_char ilike :q OR simplified_char ilike :q', q: "%#{query}%").to_a.uniq { |w| w.meaning}.sort_by! { |w| w.simplified_char.length}
    # else
    #   return
    end
  end
end
