input = File.read("input").strip

input.to_enum(:scan, /(\d)\1+/).map {Regexp.last_match }

#+ 6 because of list wrapping and i'm lazy
part1 = input.to_enum(:scan, /(\d)\1+/).map {Regexp.last_match[1].to_i * (Regexp.last_match[0].size() -1) }.sum + 6

puts "part 1 #{part1}"

part2 = input.chars.select.with_index {|c,i|  c == input[i + input.size/2] }.map{|c| c.to_i * 2}.sum
puts "part 2 #{part2}"
