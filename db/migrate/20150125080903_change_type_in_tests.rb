class ChangeTypeInTests < ActiveRecord::Migration
  def change
    rename_column :reading_tests, :type, :test_type
  end
end
