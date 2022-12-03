input = File.read("#{__DIR__}/day03.txt").split("\n")
priority = ('a'..'z').zip(1..26).concat(('A'..'Z').zip(27..52)).to_h
puts input.sum { |line| priority[(line[..line.size//2].chars & line[line.size//2..].chars).first] }
puts input.each_slice(3).sum { |lines| priority[lines.map(&.chars).reduce { |a, b| a & b }.first] }
