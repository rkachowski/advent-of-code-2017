require 'set'

banks = File.read("input").split("\t").map(&:to_i)

def redistribute arr
  index = arr.index arr.max
  blocks = arr[index]
  arr[index] = 0

  blocks.times {|t| arr[(t + index + 1) % arr.size] += 1}
  arr.to_s
end

def loops_til_duplicate banks, seen=Set.new
  count = 0
  redist = nil

  loop do
    redist = redistribute(banks)
    count += 1
    break if seen.include? redist
    seen << redist
  end

  [ count, redist ]
end

part1, match = loops_til_duplicate banks
part2, _ = loops_til_duplicate banks, Set.new( [match])

puts part1
puts part2
