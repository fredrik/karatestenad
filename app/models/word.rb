class Word < ActiveRecord::Base
  before_create :set_normalized_word
  
  def self.normalize_word(w)
    # Some explanation is required; .downcase converts the title to lower case, the 1st .gsub strips out anything not alphanumeric and turns it into a hyphen, and the 2nd .gsub changes any multiple hyphens into a single hyphen.
    # from http://www.seoonrails.com/to_param-for-better-looking-urls
    "#{w.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
  end

  def set_normalized_word
    definition = "egads"
    #normalized_word = "EGADS"
    #normalized_word = Word.normalize_word word
  end

  def to_param
    normalized_word
  end

end
