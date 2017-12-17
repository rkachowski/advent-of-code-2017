input = 314

buffer = [0]

position = buffer.first
2017.times do |i|
  position = ((input + position) % buffer.size) + 1
  to_insert = i+1
  buffer.insert position, to_insert

end

index = buffer.index 2017
puts buffer[(index - 2)..(index + 2)].to_s

value_after_zero = 0
pos = 0
(1..50000000).each do |n|
  pos = (pos + input) % n
  value_after_zero = n if pos == 0
  pos += 1
end

puts value_after_zero
