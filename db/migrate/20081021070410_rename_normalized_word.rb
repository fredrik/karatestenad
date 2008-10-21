class RenameNormalizedWord < ActiveRecord::Migration
  def self.up
    rename_column :words, :normalized_word, :normalized
  end

  def self.down
    rename_column :words, :normalized, :normalized_word
  end
end
