input = File.read("input").lines.map(&:chars)
#input = 
#"     |
#     |  +--+
#     A  |  C
# F---|----E|--+
#     |  |  |  D
#     +B-+  +--+
#".lines.map(&:chars)

p = [0,input.first.index("|")]
d = [1,0]

max = [input.size, input.max{|a,b| a.size <=> b.size}.size]
extents = max.map{|s| 0...s}
input.each {|l| (max[1] - l.size).times { l << " " }}

letters = []
stops = 0
travels = 0
add = ->(a,b){a[0] += b[0]; a[1] += b[1]; travels += 1}
loop do
  add.call(p,d) until input[p[0]][p[1]] =~ /\+|[A-Z]|\s/

  if input[p[0]][p[1]] =~ /[A-Z]/
    letters << input[p[0]][p[1]]
  else
    puts  "encountered #{input[p[0]][p[1]]} at #{p.to_s} after #{travels} steps"
    choices = [d.rotate, d.rotate.map{|i| i *= -1}]
    valid = choices.reject do |c| 
      x = c[0] + p[0]
      y = c[1] + p[1]

      #puts "[#{x}][#{y}] = #{input.at(x)&.at(y) }"
      !extents[0].include?(x) or !extents[1].include?(y) or input[x][y] =~ /\s/
    end

    break if valid.size == 0

    stops += 1
    d = valid.first
  end

  add.call(p,d)
end

puts letters.join
puts stops
puts input.flatten.count "+"
