class AddWordsToTexts < ActiveRecord::Migration
  def change
    add_column :texts, :words, :hstore, default: {}
  end
end
