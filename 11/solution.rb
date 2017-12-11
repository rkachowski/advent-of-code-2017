input = File.read("input").chomp.split(",")

start = [0,0,0]

def move dir, curr
  to_add = case dir
  when "n"
     [0,1,-1]
  when "s"
     [0,-1, 1]
  when "ne"
     [1,0, -1]
  when "nw"
     [-1,1, 0]
  when "se"
     [1,-1, 0]
  when "sw"
     [-1,0, 1]
  end

  to_add.each_with_index {|d,i| curr[i] += d}
end

def distance a,b
  ((a[0] - b[0]).abs + (a[1] - b[1]).abs + (a[2] - b[2]).abs) / 2
end

max = 0
input.each {|d| move d, start; max = [max, distance(start,[0,0,0])].max}

puts distance(start,[0,0,0])
puts max
