class Word < ActiveRecord::Base
  before_create :set_normalized_word
  
  validates_uniqueness_of :word
  validates_uniqueness_of :normalized_word  
  
  def self.normalize_word(w)
    # Some explanation is required: the 1st .gsub strips out anything not alphanumeric and turns it into a hyphen,
    # the 2nd .gsub changes any multiple hyphens into a single hyphen.
    # from http://www.seoonrails.com/to_param-for-better-looking-urls
    w.gsub '!', 'exclamation_mark'
    w.gsub '?', 'question_mark'
    w.gsub '.', 'full_stop'
    "#{w.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
  end

  def set_normalized_word
    write_attribute("normalized_word", Word.normalize_word(word))
  end

  def to_param
    normalized_word
  end

end
