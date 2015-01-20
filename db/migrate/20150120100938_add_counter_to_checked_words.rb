class AddCounterToCheckedWords < ActiveRecord::Migration
  def change
    add_column :checked_words, :counter, :integer, default: 0
  end
end
