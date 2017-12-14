input = File.read("input").lines
input.map!{ |i| i.scan(/(\d+): (\d+)/).flatten.map(&:to_i) }

firewall = {}

input.each {|(i,l)| firewall[i] = l}
(0..firewall.keys.last).each {|c| firewall[c] ||= nil }

def severity firewall, delay=0
  (0..firewall.keys.max).inject(0) do |acc,i|
    scan = firewall[i]
    if scan and (delay+i) % (2*scan - 2 ) == 0
      acc += scan.size * i
      return 1 if delay > 0
    end

    acc
  end
end

puts severity(firewall)

delay = 1
score = severity(firewall, delay)

until score == 0
  delay +=1
  score = severity(firewall, delay)
end

puts delay

