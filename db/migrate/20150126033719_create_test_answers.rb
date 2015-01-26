class CreateTestAnswers < ActiveRecord::Migration
  def change
    create_table :test_answers do |t|
      t.references :reading_test, index: true
      t.references :user, index: true
      t.string :answer
      t.boolean :correct

      t.timestamps
    end
  end
end
