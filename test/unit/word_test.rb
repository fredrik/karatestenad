require '../test_helper'
include ActionView::Helpers::ActiveRecordHelper
class WordTest < ActiveSupport::TestCase
  
  def test_should_allow_only_unique_words
    once = Word.create :word => "egads"    
    assert once.valid?
    twice = Word.create :word => "egads"
    assert (not twice.valid?)
  end
  
  def test_two_yeahs_are_not_equal
    yeahs = Word.create :word => "yeah?"
    yeahz = Word.create :word => "yeah!"
    assert_not_equal yeahs.normalized, yeahz.normalized
  end

  def test_should_disallow_nonunique_normalizations
    x = Word.create :word => "yeah"
    assert x.valid?
    y = Word.create :word => "yeah"
    assert (not y.valid?)
  end
  
  def test_should_set_normalized
    w = Word.create :word => "sure stuffs", :definition => "that which we know to be true"
    assert_equal w.normalized, "sure-stuffs"
  end
  
  def test_should_not_be_able_to_change_word
    
  end
  
  # helper.
  def test_half
    # not finding an easy way to test helpers; skipping.
    #assert_equal [[],[]], half([])
  end
  
  def test_normalize
    assert_equal Word.normalize('-'), 'dash'
    assert_equal Word.normalize('+'), 'plus'
    assert_equal Word.normalize('++'), 'plus-plus'
  end
  
end
