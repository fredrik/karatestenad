module WordsHelper

  # splits the content of the array of stuffs into some number of arrays?
  # probably.
  def partition(stuffs)
    half(stuffs)
  end
  
  # one basic method. half the input into two basically equally sized partitions.
  def half(stuffs)
    return [[],[]] if stuffs.nil? or stuffs.empty? 
    cut = stuffs.size/2
    a = stuffs[0..cut]
    b = stuffs[cut+1..stuffs.size]
    [a,b]
  end
  
end
