hands = {
  "A" => 0,
  "B" => 1,
  "C" => 2,
  "X" => 0,
  "Y" => 1,
  "Z" => 2,
}

input = File.read("#{__DIR__}/day02.txt").split("\n").map { |r| r.split.map { |h| hands[h] } }
puts input.sum { |(a, b)| {3, 0, 6}[(a - b) % 3] + b + 1 }
puts input.sum { |(a, b)| {0, 3, 6}[b] + (a + {-1, 0, 1}[b]) % 3 + 1 }
