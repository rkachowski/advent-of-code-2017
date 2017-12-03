def get_edge_length num
  l = Math.sqrt(num).ceil
  l.even? ? l + 1 : l
end

def to_coords num
  edge_length = get_edge_length num
  diff = edge_length ** 2 - num

  position = [edge_length-1, edge_length-1]
  dec = [-1,-1]
  dec_index = 0

  count = 1

  (diff).times do |i|
    position[dec_index] += dec[dec_index]

    count += 1
    if count % edge_length == 0
      dec[dec_index]*= -1

      count = 1
      dec_index +=1
      dec_index = 0 if dec_index > 1
    end

    #puts "diff: #{diff} i: #{i} position: #{position.to_s} dec: #{dec.to_s} dec_index: #{dec_index}"
  end

  offset = (edge_length-1)/2
  position.map{|n| n - offset}
end

def part1 num
  to_coords(num).map(&:abs).sum
end

puts part1(325489)
