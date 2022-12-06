input = File.read("#{__DIR__}/day06.txt")
puts input.lines.flat_map(&.each_char.cons(4).with_index.to_a).find { |s, _| s.uniq.size == s.size }.not_nil!.last + 4
puts input.lines.flat_map(&.each_char.cons(14).with_index.to_a).find { |s, _| s.uniq.size == s.size }.not_nil!.last + 14
