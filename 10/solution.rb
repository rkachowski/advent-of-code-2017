input = File.read("input").chomp.split(",").map(&:to_i)

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

list = (0..255).to_a
round list, input

puts list[0] * list[1]

## part2
part2_input = File.read("input").chomp.bytes
list = (0..255).to_a

def get_hash input
  input.concat [17, 31, 73, 47, 23]
  list = (0..255).to_a

  64.times.inject([0,0]) { |o| round list, input, *o }
  dense_hash = list.each_slice(16).map{ |sl| sl.reduce(&:^) }
  dense_hash.map{|c| c.to_s(16).rjust(2,"0")}.join
end

puts get_hash(part2_input)
