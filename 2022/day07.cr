path = Path.new
dirs = {"/" => 0}

File.read("#{__DIR__}/day07.txt").lines.each do |line|
  case line
  when .=~ /^\$ cd ..$/
    path = path.parent
  when .=~ /^\$ cd (.+)$/
    path = path.join($1)
  when .=~ /^dir (.+)$/
    dirs[path.join($1).to_s] = 0
  when .=~ /^(\d+) (.+)$/
    path.each_parent { |p| dirs[p.to_s] += $1.to_i }
    dirs[path.to_s] += $1.to_i
  end
end

puts dirs.select { |_, v| v <= 100000 }.values.sum
puts dirs.select { |_, v| v >= 30000000 - (70000000 - dirs["/"]) }.values.min
