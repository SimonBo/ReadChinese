class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.text :content
      t.string :source
      t.references :user, index: true

      t.timestamps
    end
  end
end
