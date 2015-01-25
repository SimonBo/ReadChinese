class CreateReadingTests < ActiveRecord::Migration
  def change
    create_table :reading_tests do |t|
      t.references :user, index: true
      t.references :text, index: true
      t.hstore :data, default: {}
      t.string :type, default: ""

      t.timestamps
    end
    add_index :reading_tests, [:data], name: "reading_tests_gin_data", using: :gin
  end
end
