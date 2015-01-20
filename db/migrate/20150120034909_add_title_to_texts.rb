class AddTitleToTexts < ActiveRecord::Migration
  def change
    add_column :texts, :title, :string, null: false
  end
end
