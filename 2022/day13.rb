pairs = File.read("#{__dir__}/day13.txt").split("\n\n").map { |l| l.split("\n").map { |p| eval(p) } }

def is_right_order?(l, r)
  l = Array(l)
  r = Array(r)

  return l <=> r if l.empty? || r.empty?

  0.upto([l.size, r.size].min - 1) do |i|
    cmp = l[i].is_a?(Array) || r[i].is_a?(Array) ? is_right_order?(l[i], r[i]) : l[i] <=> r[i]
    return cmp unless cmp == 0
  end

  return l.size <=> r.size
end

puts pairs.each.with_index.sum { |(l, r), i| is_right_order?(l, r) == -1 ? i + 1 : 0 }
puts pairs.flatten(1).push([[2]], [[6]]).sort { |a, b| is_right_order?(a, b) }.each_with_index.filter_map { |p, i| i + 1 if p == [[2]] || p == [[6]] }.reduce(:*)
