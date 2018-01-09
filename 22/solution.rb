input = File.read("input").lines.map(&:chomp)

max_x, max_y = input.first.size, input.size
offset = [max_x / 2, max_y / 2]

@position = [0, 0]
@directions = [[0,-1],[1,0],[0,1],[-1,0]]
@direction = 0

@grid = Hash.new {|hsh,k| hsh[k] = "." }

(0...max_y).each do |y|
  (0...max_x).each do |x|
    px = x - offset[0]
    py = y - offset[1]

    @grid[[px,py]] = input[y][x]
  end
end

def burst_pt1
  inc = 0
  infected = false

  case @grid[@position]
  when "."
    inc = -1
    infected = true
    @grid[@position] = "#"
  when "#"
    inc = 1
    @grid[@position] = "."
  end

  @direction = (@direction + inc) % 4

  @position = [@position[0] + @directions[@direction][0], @position[1] + @directions[@direction][1]]
  infected
end


def burst_pt2
  inc = 0
  infected = false

  case @grid[@position]
  when "."
    inc = -1
    @grid[@position] = "W"
  when "#"
    inc = 1
    @grid[@position] = "F"
  when "W"
    infected = true
    @grid[@position] = "#"
  when "F"
    inc = 2
    @grid[@position] = "."
  end

  @direction = (@direction + inc) % 4

  @position = [@position[0] + @directions[@direction][0], @position[1] + @directions[@direction][1]]
  infected
end

def print_grid
  output = []

  (-10..10).to_a.each do |y|
    line = []
    (-10..10).to_a.each do |x|
      line << @grid[[x,y]]
    end
    output << line.join
  end

  puts output
  puts "p: #{@position.to_s}"
  puts "d: #{@directions[@direction].to_s}"
end

