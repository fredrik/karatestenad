class CreateWords < ActiveRecord::Migration
  def self.up
    create_table :words do |t|
      t.string :word # not null!
      t.string :normalized_word # not null!
      t.string :definition

      t.timestamps
    end
    
    # word and normalized_word are unique, you know
    add_index(:words, :word, {:name => "words_are_unique", :unique => true})
    add_index(:words, :normalized_word, {:name => "normalized_words_are_unique", :unique => true})
    
    
  end

  def self.down
    drop_table :words
  end
end
