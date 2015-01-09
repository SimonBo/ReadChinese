class CreateFavoriteWords < ActiveRecord::Migration
  def change
    create_table :favorite_words do |t|
      t.references :user, index: true
      t.references :word, index: true

      t.timestamps
    end
  end
end
