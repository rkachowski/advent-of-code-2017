input = File.read("input").lines

input.map! do |line|
  matches = line.scan(/([-\d]+),([-\d]+),([-\d]+)/)
  matches.map { |c| c.map!(&:to_i) }
end

add = ->(ar, ar2) { ar[0] += ar2[0] ; ar[1] += ar2[1] ; ar[2] += ar2[2] }
tick = ->(p){ add.call(p[1],p[2]); add.call(p[0],p[1]) }

mags = input.map { |p| Math.sqrt(p[2][0]**2 + p[2][1]**2 + p[2][2]**2) }
puts mags.index(mags.min)

20000.times do |i|
  positions = Hash.new {|hsh,k| hsh[k] = []}
  input.each { |p| tick.call(p); positions[p[0].to_s] << p }

  to_delete = positions.values.select { |v| v.size > 1 }
  to_delete.each {|ps| ps.each {|p|input.delete(p)}}
end

puts input.size
