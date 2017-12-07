require 'pry-byebug'
def parse_input
  input = File.read("input").lines

  input.map do |l|
    name_and_weights = l.scan(/^(\w+)\s\((\d+)\)/).flatten
    children = l.split("->").last.scan(/\w+/) if l.include? "->"

    {
      :name => name_and_weights[0],
      :weight => name_and_weights[1].to_i,
      :children => children || []
    }
  end
end


nodes = parse_input

root = nodes.map{|c| c[:name]} - nodes.map{|c| c[:children]}.flatten.uniq
root = root.first

puts "part 1 : #{root}"


def combined_weight node, nodes
  nodes[node][:weight] + (nodes[node][:children]&.map{|c| combined_weight c, nodes}&.sum || 0)
end

def balanced? node, nodes
  children = nodes[node][:children]
  combined_weights = children.map {|n| weight n, nodes} if children

  combined_weights.uniq.size < 2
end

nodes = nodes.each_with_object({}){|n, hsh| hsh[n[:name]] = {weight: n[:weight], children: n[:children]}}

#walk to unbalanced node
unbalanced = root
loop do
  unbalanced_child = nodes[unbalanced][:children].select{|c| not balanced? c, nodes}.first
  break unless unbalanced_child
  unbalanced = unbalanced_child
end

weights = nodes[unbalanced][:children].each_with_object({}) do |n,hsh| 
  hsh[combined_weight(n, nodes)] ||= []
  hsh[combined_weight(n, nodes)] << n
end

node_to_change = weights.values.min {|a,b| a.size <=> b.size}.first
desired_weight = combined_weight weights.values.max {|a,b| a.size <=> b.size}.first, nodes

puts nodes[node_to_change][:weight] + (desired_weight - combined_weight(node_to_change, nodes))
