    input = File.read("input").lines
    parsed = input.map {|l| l.scan(/(\w+)\s(\w+)\s(-?\d+)(.*)/).flatten}
    registers = parsed.map {|p| p.first}.uniq
    max = 0
    b = Kernel.binding
    registers.each {|r| b.eval "#{r} = 0"}
    parsed.each {|p| b.eval "#{p[0]} #{p[1] == "inc" ? "+" : "-"}= #{p[2]} #{p[3]}; max = [max, #{p[0]}].max" }
    puts registers.map{|r| b.local_variable_get(r.to_sym)}.max
    puts b.local_variable_get(:max)
