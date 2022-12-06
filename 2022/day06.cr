input = File.read("#{__DIR__}/day06.txt")
solve = ->(n : Int32) { input.each_char.cons(n).index!(&.uniq.size.== n) + n }
puts solve.call(4), solve.call(14)
