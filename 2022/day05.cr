stack_layout, move_instructions = File.read("#{__DIR__}/day05.txt").split("\n\n")
stacks = stack_layout.lines[..-2].map { |line| (1..line.size).step(4).map { |i| line[i] }.to_a }.transpose.map(&.select(&.letter?))
moves = move_instructions.lines.map(&.scan(/\d+/).map(&.[0].to_i))

puts moves.each_with_object(stacks.clone) { |(n, from, to), stacks|
  stacks[from - 1].shift(n).each { |crate| stacks[to - 1].unshift(crate) }
}.map(&.first).join

# Part 2
puts moves.each_with_object(stacks.clone) { |(n, from, to), stacks|
  stacks[from - 1].shift(n).reverse.each { |crate| stacks[to - 1].unshift(crate) }
}.map(&.first).join
