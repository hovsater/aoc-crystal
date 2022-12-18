ROCK_POINTS = File.readlines("#{__dir__}/day14.txt").flat_map do |line|
  line.split(" -> ").each_cons(2).flat_map do |c1, c2|
    x1, y1 = c1.split(",").map(&:to_i)
    x2, y2 = c2.split(",").map(&:to_i)
    x_range = x1 < x2 ? x1..x2 : x2..x1
    y_range = y1 < y2 ? y1..y2 : y2..y1
    x_range.cycle(y_range.size).zip(y_range.cycle(x_range.size))
  end
end

CAVE_X_BOUND = 680
CAVE_Y_BOUND = ROCK_POINTS.map(&:last).max

def part1
  cave = Array.new(CAVE_Y_BOUND + 1) { Array.new(CAVE_X_BOUND, ".") }
  ROCK_POINTS.each { |x, y| cave[y][x] = "#" }
  count = 0

  loop do
    sx, sy = [500, 0]

    while sy < CAVE_Y_BOUND
      if cave[sy + 1][sx] == "."
        sy = sy + 1
      elsif cave[sy + 1][sx - 1] == "."
        sx = sx - 1
        sy = sy + 1
      elsif cave[sy + 1][sx + 1] == "."
        sx = sx + 1
        sy = sy + 1
      else
        count += 1
        cave[sy][sx] = "o"
        break
      end
    end

    break if sy >= CAVE_Y_BOUND
  end

  count
end

def part2
  cave = Array.new(CAVE_Y_BOUND + 1) { Array.new(CAVE_X_BOUND, ".") }
  cave.push(["."] * CAVE_X_BOUND)
  cave.push(["#"] * CAVE_X_BOUND)
  ROCK_POINTS.each { |x, y| cave[y][x] = "#" }
  count = 0

  while true
    sx, sy = [500, 0]

    while sy < CAVE_Y_BOUND + 2
      if cave[sy + 1][sx] == "."
        sy = sy + 1
      elsif cave[sy + 1][sx - 1] == "."
        sx = sx - 1
        sy = sy + 1
      elsif cave[sy + 1][sx + 1] == "."
        sx = sx + 1
        sy = sy + 1
      else
        count += 1
        cave[sy][sx] = "o"
        break
      end
    end

    break if sx == 500 && sy == 0
  end

  count
end

puts(part1)
puts(part2)
