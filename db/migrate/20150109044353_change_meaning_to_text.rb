class ChangeMeaningToText < ActiveRecord::Migration
  def change
    change_column :words, :meaning, :text
  end
end
