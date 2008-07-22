class Word < ActiveRecord::Base

  validates_uniqueness_of :word
  validates_uniqueness_of :normalized_word  

  before_create :set_normalized_word
  def set_normalized_word
    write_attribute("normalized_word", Word.normalize(word))
  end
  
  def self.normalize(word)
    w = word.dup
    w.gsub! '!', 'exclamationmark'
    w.gsub! '?', 'questionmark'
    w.gsub! ':', 'colon'
    w.gsub! '.', 'dot'
    w.gsub! ',', 'comma'
    # Some explanation is required: the 1st .gsub strips out anything not alphanumeric and turns it into a hyphen,
    # the 2nd .gsub changes any multiple hyphens into a single hyphen.
    # from http://www.seoonrails.com/to_param-for-better-looking-urls
    "#{w.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
  end


  def to_param
    normalized_word
  end

  def to_html
    BlueCloth.new(definition).to_html
  end

end
