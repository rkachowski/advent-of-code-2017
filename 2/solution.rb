input = File.read("input")

parsed = input.strip.lines.map{|l| l.strip.split("\t").map(&:to_i) }
puts parsed.map {|line| line.max - line.min}.sum


def find_integer_division arr
  arr.each do |n|
    others = arr.clone
    others.delete n
    others.each { |d| return n / d if n % d == 0 }
  end
end

part2 = parsed.map {|line| find_integer_division(line)}.sum

puts part2

