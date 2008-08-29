module WordsHelper

  # splits the content of the array of stuffs into some number of arrays?
  # probably.
  def partition(stuffs)
    cut = stuffs.size/2
    a = stuffs[0..cut]
    b = stuffs[cut+1..size]
    [a,b]
  end
  
end
