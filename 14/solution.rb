input = "hfdlxzhv"
#input = "flqrgnkx"

def pinch_and_stuff arr, position, length
  return if length < 2
  slice = arr.slice(position, length)
  slice.concat(arr.slice(0, (position + length) % arr.size))
  slice.reverse!

  length.times do |i|
    index = (position + i) % arr.size
    arr[index] =slice[i]
  end
end

def round list, input, current_position=0, skip_size=0
  input.each do |l|
    pinch_and_stuff list, current_position, l

    current_position += l + skip_size
    current_position = current_position % list.size
    skip_size += 1
  end

  [current_position, skip_size]
end

def get_hash input
  input.concat [17, 31, 73, 47, 23]
  list = (0..255).to_a

  64.times.inject([0,0]) { |o| round list, input, *o }
  dense_hash = list.each_slice(16).map{ |sl| sl.reduce(&:^) }
  dense_hash.map{|c| c.to_s(16).rjust(2,"0")}.join
end

hashes = (0..127).to_a.map do |i|
  code = input + "-#{i}"
  hash = get_hash(code.bytes)
  hash.chars.map{|c|c.hex.to_s(2).rjust(4,"0").gsub("1","#").gsub("0",".")}.join
end

#puts hashes.slice(0,8).map {|h| h.slice(0,8)}
puts hashes.join.chars.count("#")

#part 2
hashes.map!(&:chars)

$current_group = 0

def hashes.neighbours cell
  x, y = cell

  [[x-1,y], [x+1,y], [x,y-1], [x,y+1]].reject {|c| c.any?{|e| e < 0 or e >= 128}}
end

def flood_fill value, grid, cell=[0,0]
  return false unless grid[cell[0]][cell[1]] == "#"

  grid[cell[0]][cell[1]] = value
  grid.neighbours(cell).each {|c| flood_fill(value,grid, c)}

  true
end

def print g
  puts g.slice(0,20).map {|h| h.join.slice(0,20)}
end


hashes.each_index do |y|
  hashes.fetch(y).each_index do |x|

    result = flood_fill $current_group, hashes, [x,y]
    $current_group += 1 if result
  end
end


puts hashes.flatten.uniq.size - 1
