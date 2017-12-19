input = File.read("input").lines

class Instructions
  def self.get regs
    val = ->(v){ if v =~ /[a-z]/ then regs[v].to_i else v.to_i end}

    {
      "set" => ->(r,v){regs[r] = val.call(v)},
      "add" => ->(r,r2){regs[r] += val.call(r2)},
      "mul" => ->(r,r2){regs[r] *= val.call(r2)},
      "mod" => ->(r,r2){regs[r] = val.call(r) % val.call(r2)},
      "snd" => ->(r, _){regs[:snd] = val.call(r)},
      "rcv" => ->(r, _){ if val.call(r) > 0; puts regs[:snd]; regs[:snd]; end },
    }
  end
end

class Program
  attr_reader :recv_queue, :status, :send_count

  def initialize pid, input
    @pid = pid
    @input = input
    @regs = {}
    @status = :pending
    @eip = 0
    @recv_queue = []
    @send_count = 0

    input.map{|l| l.scan(/\w+\s([a-z])/) }.uniq.each{|r| @regs[r.flatten.first] = 0}
    @regs["p"] = pid
    @prog = pid

    @instrs = Instructions.get @regs
  end

  def val v
    return @regs[v] if v =~ /[a-z]/
    v.to_i
  end

  def setup send_queue
    @instrs["snd"] = ->(r, _) {@send_count += 1; send_queue.push val(r)}
    @instrs["rcv"] = ->(r, _) do
      v = @recv_queue.shift
      v ? @regs[r] = v : @status = :recieving
    end
  end

  def step
    return if @status == :terminated

    unless @eip >= 0 and @eip < @input.length
      @status = :terminated
      return
    end

    @status = :running
    instr, reg, arg = @input[@eip].match(/(\w+)\s(\w) ?([\w-]+)?/).captures
    @instrs[instr]&.call(reg,arg)

    should_inc = ! [:recieving, :terminated].include?(@status)
    return unless should_inc

    inc = 1
    inc = val(arg) if instr == "jgz" and val(reg) > 0
    @eip += inc
  end
end

p0 = Program.new 0, input
p1 = Program.new 1, input

p0.setup p1.recv_queue
p1.setup p0.recv_queue

failed = ->() do
  p0.step
  p1.step
  (p0.status == :terminated && p1.status == :terminated) || 
  (p0.status == :recieving && p1.status == :recieving) 
end

until failed.call do
  [p0,p1].each {|p| p.step until p.status == :recieving or p.status == :terminated}
end

puts p1.send_count
