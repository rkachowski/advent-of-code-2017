@pattern = <<~PATTERN
    .#.
    ..#
    ###
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

input = File.read("input").lines
#input = " ../.# => ##./#../...
#.#./..#/### => #..#/..../..../#..#
#".chomp.lines

input.map! {|l| l.split(" => ").map(&:strip)}


rules = Hash.new {|hash, k| hash[k] = {} }


input.each do |inp, outp|
  puts inp
  pats = inp.split("/")
  pats.inject(rules) do |m,p|
    if p.equal? pats.last
      m[p] = outp.strip.chomp
    else
      m[p] = Hash.new {|hash, k| hash[k] = {} } unless m[p].keys.size > 0
    end
    m[p]
  end
end
 puts rules
