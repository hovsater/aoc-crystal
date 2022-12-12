class Point
  property x, y

  def initialize(@x : Int32, @y : Int32)
  end
end

def move_rope(rope, direction)
  case direction
  when "U", "D" then rope.first.y += direction == "U" ? 1 : -1
  when "L", "R" then rope.first.x += direction == "R" ? 1 : -1
  end

  rope.each_cons(2).each do |(h, t)|
    if (h.x - t.x).abs > 1 && (h.y - t.y).abs > 1
      t.y += h.y > t.y ? 1 : -1
      t.x += h.x > t.x ? 1 : -1
    elsif (h.x - t.x).abs > 1
      t.x += h.x > t.x ? 1 : -1
      t.y = h.y
    elsif (h.y - t.y).abs > 1
      t.y += h.y > t.y ? 1 : -1
      t.x = h.x
    end
  end
end

rope = Array.new(10) { Point.new(0, 0) }
tail_positions = Array.new(2) { Set(Tuple(Int32, Int32)).new }

File.read_lines("#{__DIR__}/day09.txt").each do |line|
  direction, amount = line.split

  amount.to_i.times do
    move_rope(rope, direction)
    tail_positions[0].add({rope[+1].x, rope[+1].y})
    tail_positions[1].add({rope[-1].x, rope[-1].y})
  end
end

puts tail_positions[0].size
puts tail_positions[1].size
