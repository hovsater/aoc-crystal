input = File.read("#{__dir__}/day04.txt").split("\n").map { |l| l.scan(/(\d+)-(\d+)/).map { |a, b| Range.new(a.to_i, b.to_i) } }
puts input.count { |(a, b)| a.cover?(b) || b.cover?(a) }
puts input.count { |(a, b)| a.any? { |n| b.cover?(n) } }
