def jump &blk
    input = File.read("input").lines.map(&:to_i)

    index = 0
    steps = 0

    while index < input.size
        to_move = input[index]
        input[index] += blk ? blk.call(to_move) : 1
        index += to_move

        steps += 1
    end

    steps
end

puts jump
puts jump {|f| f >= 3 ? -1 : 1}
