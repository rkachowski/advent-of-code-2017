input = File.read("input").chomp.split(",").map(&:chars)
input.map! do |line|
  op = line.shift
  args = line.join.split("/")
  args.map!(&:to_i) unless op == "p"

  [op.to_sym, args]
end

def s arr, v
  arr.rotate!(-v)
end

def x arr, a,b
  arr[a], arr[b] = arr[b], arr[a]
end

def p arr, a, b
  x arr, arr.index(a), arr.index(b)
end

arr = ("a".."p").to_a

def dance input, arr
  input.each { |(op, args)| send op, arr, *args }
end

dance input, arr
puts arr.join

arr = ("a".."p").to_a
seen = []
1000000000.times do |i|
  if seen.include? arr.join
    puts seen[1000000000 % i]
    break
  end

  seen << arr.join
  dance input, arr
end

