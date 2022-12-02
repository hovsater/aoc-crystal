hands = {
  "A" => 0,
  "B" => 1,
  "C" => 2,
  "X" => 0,
  "Y" => 1,
  "Z" => 2,
}

input = File.read("#{__DIR__}/day02.txt").split("\n").map { |r| r.split.map { |h| hands[h] } }
puts input.sum { |(a, b)| (b - a + 1) % 3 * 3 + b + 1 }
puts input.sum { |(a, b)| b * 3 + (a + b - 1) % 3 + 1 }
