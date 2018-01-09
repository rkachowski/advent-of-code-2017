require 'json'

@pattern = <<~PATTERN
    .#.
    ..#
    ###
PATTERN

def clone_pat pat
  JSON.parse(JSON.generate(pat))
end

@pattern = @pattern.lines.map(&:chomp).map(&:chars)

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

def extract_segments pats
  split_size = pats.first.size % 2 == 0 ? 2 : 3

  segs = []

  pats.each_with_index do |row,y|
    row.each_with_index do |_,x|
      position = (((y/split_size).floor * row.size + x) / split_size).floor
      segs[position] ||=[]
      segs[position] << pats[y][x]
    end
  end

  segs.map{|s| s.each_slice(split_size).to_a}
end

#create a tree of rules
@rules = Hash.new {|hash, k| hash[k] = {} }
input = File.read("input").lines
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

@rules = clone_pat @rules

def iterate
  squares = extract_segments @pattern

  output = squares.map { |s| find_rule s, @rules }
  sq_size = Math.sqrt(output.size).to_i
  o = output.each_slice(sq_size).to_a

  o.map!{|s|s.map{|f| f.split("/")}}
  output = o.map {|s| s[0].zip(*s[1..-1])}.flatten(1).map {|s| s.map(&:chars).flatten(1) }
  puts output.flatten.count("#")
  output
end

def permute sq
  p = clone_pat sq

  return enum_for(:permute, p) unless block_given?

  [p, flip_x(p), flip_y(p), flip_x(flip_y(p))].lazy.each do |v|
    yield v
    yield rotate(v)
    yield rotate(rotate(v))
    yield rotate(rotate(rotate(v)))
  end
end

def find_rule seq, rules
  permute(seq).each { |p|
    o = p.map(&:join)
   return rules.dig(*o) if rules.dig(*o)}

  puts "failed to find rule for #{seq.to_s}"
  nil
end

