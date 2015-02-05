class AddFavoriteWordsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :favorite_words, :integer, default: [], array: true
  end
end
