class CreateReadingTests < ActiveRecord::Migration
  def change
    create_table :reading_tests do |t|
      t.references :text, index: true
      t.references :user, index: true
      t.references :correct_answer, index: true
      t.boolean :score
      t.references :answer_given, index: true

      t.timestamps
    end
  end
end
