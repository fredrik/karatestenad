require '../test_helper'

class WordTest < ActiveSupport::TestCase

  def test_should_allow_only_unique_words
    once = Word.create :word => "egads"    
    assert once.valid?
    twice = Word.create :word => "egads"
    assert (not twice.valid?)
  end

  def test_should_disallow_nonunique_normalizations
    # both "yeah?" and "yeah!" yield the same normalization
    x = Word.create :word => "yeah?"
    assert x.valid?
    y = Word.create :word => "yeah!"
    assert (not y.valid?)
    
  end
  
  def test_should_set_normalized
    w = Word.create :word => "sure stuffs", :definition => "that which we know to be true"
    assert_equal w.normalized, "sure-stuffs"
  end
  
  def test_should_not_be_able_to_change_word
    
  end
  
  
end
