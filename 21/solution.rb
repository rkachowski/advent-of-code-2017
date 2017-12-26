@pattern = <<~PATTERN
    .#..#.
    ..#..#
    ######
    .#..#.
    ..#..#
    ######
PATTERN

def flip_x pat
  pat.dup.each { |l| last = l.size - 1;  l[0], l[last]  = l[last],l[0]}
end

def flip_y pat
  pat = pat.transpose
  flip_x pat
  pat.transpose
end

def rotate pat
  p = pat.transpose
  p.map!(&:reverse)
  p
end

def pat arr
  arr.each {|l| puts l.join}
end

def extract_segments size, pats
  p = pats.each_slice(size).map{|l| l.flatten.each_slice(size).to_a }
  even_segs = p.map {|l| l.select.with_index {|_,i| i.even? }.flatten}
  odd_segs = p.map {|l| l.select.with_index {|_,i| i.odd? }.flatten}
  even_segs.zip( odd_segs).flatten(1)
end

@rules = Hash.new {|hash, k| hash[k] = {} }
input = File.read("input").lines
input = "../.# => ##./#../...
.#./..#/### => #..#/..../..../#..#".lines
input.map! {|l| l.split(" => ").map(&:strip)}

input.each do |inp, outp|
  pats = inp.split("/")
  pats.inject(@rules) do |m,p|
    if p.equal? pats.last
      m[p] = outp.strip.chomp
    else
      m[p] = Hash.new {|hash, k| hash[k] = {} } unless m[p].keys.size > 0
    end
    m[p]
  end
end

def iterate
  #assume square
  pat @pattern
  split_size = @pattern.first.size % 2 ? 2 : 3
  if @pattern.first.size % 2
    #split into twos
    @pattern.each_slice(2).to_a
  else
    #split into threes
  end

  #transform each sub pattern
  #join
end


