input = File.read("#{__DIR__}/day01.txt").split("\n\n").map { |c| c.lines.map(&.to_i).sum }
puts input.max
puts input.sort.reverse.first(3).sum
