input = File.read("input")

processed = []
index = 0
input.chars.size.times do |i|
  if input[index] == "!"
    index +=1
  else 
    processed << input[index]
  end

  index += 1
end

garbage_free = processed.join.gsub /<.*?>/, ''
result = garbage_free.chars.each_with_object({current_val: 0, total: 0}) do |c,o|
   case c
   when "{"
    o[:current_val] += 1
    o[:total] += o[:current_val]
   when "}"
    o[:current_val] -= 1
   end
end
puts result[:total]

garbages = processed.join.to_enum(:scan, /(<.*?>)/).map { Regexp.last_match }
puts garbages.map{|g| g[1].size - 2 }.sum
