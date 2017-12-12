require 'set'
require 'pry-byebug'
input = File.read("input").chomp.lines
group_map = input.each_with_object({}) do |i,hsh| 
  key, *group = i.to_enum(:scan, /(\d+)/).map { Regexp.last_match[1] }
  hsh[key] = group
end


def process_group first_member, map
  group = Set.new [first_member]
  to_process = map[first_member].clone

  until to_process.empty? do
    p = to_process.pop

    p_links = map[p]
    if p_links.any? {|pl| group.include? pl } and not group.include?(p)
      group.add p
      to_process.concat p_links
    end
  end
  group
end

zero_group = process_group "0", group_map
puts zero_group.size

groups = group_map.keys.each_with_object([]) do |k,coll|
  coll << process_group(k, group_map) unless coll.any? {|g| g.include?(k)}
end

puts groups.size
