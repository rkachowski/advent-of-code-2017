INPUT = 325489

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

DIRECTIONS = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,0],[0,1],[1,-1],[1,0],[1,1]]

def get_sum_for coords, vals
  adjacents = DIRECTIONS.map do |(x,y)|
    cell = [coords[0] + x, coords[1] + y].to_s
    vals[cell]
  end

  adjacents.compact.sum
end

def part1 num
  to_coords(num).map(&:abs).sum
end

def part2
  val = 0
  i = 0
  cells = {[0,0].to_s => 1}

  while val < INPUT do
    i += 1
    coords = to_coords(i)
    val = get_sum_for(coords, cells)
    cells[ coords.to_s ] = val
  end

  puts val
end


puts part1(INPUT)
puts part2
