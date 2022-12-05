stack_layout, move_lines = File.read("#{__DIR__}/day05.txt").split("\n\n")
*crate_distribution, stack_numbers = stack_layout.lines

stack_columns = stack_numbers
  .each_char
  .with_index
  .select(&.[0].number?)
  .map(&.[1])
  .to_a
stacks = crate_distribution
  .map { |cd| stack_columns.map { |c| cd[c] } }
  .transpose.map { |s| s.reject(&.whitespace?) }
moves = move_lines
  .split("\n")
  .map(&.scan(/\d+/).map(&.[0].to_i))

# Part 1
puts moves.each_with_object(stacks.clone) { |(n, from, to), stacks|
  stacks[from - 1].shift(n).each do |crate|
    stacks[to - 1].unshift(crate)
  end
}.map(&.first).join

# Part 2
puts moves.each_with_object(stacks.clone) { |(n, from, to), stacks|
  stacks[from - 1].shift(n).reverse.each do |crate|
    stacks[to - 1].unshift(crate)
  end
}.map(&.first).join
