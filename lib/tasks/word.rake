# working with words much?
require File.dirname(__FILE__) + '/../../config/environment'

namespace :karatestenad do
  namespace :defs do    
    desc 'for all wörds: compare static normalization of wörd with saved dito.'
    task :check_normalizations do
      changed = Word.find(:all).map {|w| w unless w.normalized == Word.normalize(w.word) }.compact
      puts 'the following normalizations differ from the recognized world standard:' if changed.size > 0
      changed.each do |w|
        puts "'#{w.word}' (normalization is #{Word.normalize(w.word)}, was #{w.normalized}"
      end
    end
  end
end

# hack first, optimize later
