class Word < ActiveRecord::Base
  validates_presence_of   :word
  validates_uniqueness_of :word
  validates_uniqueness_of :normalized

  before_create :set_normalized
  def set_normalized
    write_attribute("normalized", Word.normalize(word))
  end
  
  def validate_on_create
    if Word.disallowed_words.member?(word)
      errors.add('word', "ordet är reserverat, vilket kanske verkar lite konstigt men är egentligen fullständigt naturligt.")
    end
  end
  
  def validate_on_update
    # hm?
  end

  
  #readability: a plus.
  def self.normalize(word)
    w = word.dup.downcase
    w.gsub! '!', '-exclamationmark-'
    w.gsub! '?', '-questionmark-'
    w.gsub! ':', '-colon-'
    w.gsub! '.', '-dot-'
    w.gsub! ',', '-comma-'
    w.gsub! '$', '-dollar-'
    # TODO: add all (cool) languages and their umlautables here!
    w.gsub! 'å', 'a'
    w.gsub! 'ä', 'a'
    w.gsub! 'ö', 'o'
    # remove non-alpha chars
    w.gsub!(/[^[:alnum:]]/,'-')
    # remove repeated dashes
    w.gsub!(/-{2,}/,'-')
    # remove leading and trailing dashes
    w.gsub!(/^-*/, '')
    w.gsub!(/-*$/, '')
    return w
  end

  # this is a bug -- there are no disallowed words.
  def self.disallowed_words
    ['new', 'nowayjose']
  end
  
  
  def to_param
    normalized
  end

  def to_html
    html = BlueCloth.new(definition).to_html
    html.empty? ? "nil." : html
  end

end
