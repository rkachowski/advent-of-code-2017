input = File.read("input").lines

input.map! do |line|
  matches = line.scan(/([-\d]+),([-\d]+),([-\d]+)/)
  matches.map { |c| c.map!(&:to_i) }
end

add = ->(ar, ar2) { ar[0] += ar2[0] ; ar[1] += ar2[1] ; ar[2] += ar2[2] }
tick = ->(p){ add.call(p[1],p[2]); add.call(p[0],p[1]) }
acc = ->(a,t,v,p){ 0.5 * a * t**2 + v*t + p}
update = ->(p, t, i){ acc.call(p[2][i],t, p[1][i], p[0][i])  }
=begin
time = 99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
positions = input.map do |p|
  [update.call(p,time,0),update.call(p,time,1),update.call(p,time,2)]
end


distances = positions.map {|p| p.sum.abs  }
puts distances.index(distances.min)


=end

mags = input.map { |p| Math.sqrt(p[2][0]**2 + p[2][1]**2 + p[2][2]**2) }

puts mags.index(mags.min)
