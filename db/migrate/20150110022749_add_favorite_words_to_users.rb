class AddFavoriteWordsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :favorite_words, :integer, array: true, default: []
  end
end
