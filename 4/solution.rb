input = File.read("input").chomp

phrases = input.lines.map{|s|s.strip.split(" ")}

valid = phrases.select { |p| p.uniq.size == p.size }
puts valid.size

def anagrams phrase
  sorted = phrase.map {|w| w.chars.sort.join}
  sorted.uniq.size != phrase.size
end

valid2 = phrases.reject{|p| anagrams p }
puts valid2.size
