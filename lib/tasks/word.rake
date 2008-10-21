# working with words much?
require File.dirname(__FILE__) + '/../../config/environment'

def report_changes
  changed = Word.find(:all).map {|w| w unless w.normalized_word == Word.normalize(w.word) }.compact
  n = changed.size
  if n > 0
    puts 'the following words have had, will have or did at some point risk having their normalizations differ from the recognized world standard.'
  changed.each do |w|
    w.normalized_word
  end
end

namespace :karatestenad do
  namespace :defs do
    
    desc 'something, what I have not yet decided'
    task :check_normalizations do
      puts "checkin'"
      report_changes unless Word.find(:all).map {|w| w.normalized_word == Word.normalize(w.word) }.all?      
    end
  end
end

# hack first, optimize later
