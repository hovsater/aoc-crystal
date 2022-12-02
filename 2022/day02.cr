input = File.read("#{__DIR__}/day02.txt")

hands = {
  "A" => 1,
  "B" => 2,
  "C" => 3,
  "X" => 1,
  "Y" => 2,
  "Z" => 3,
}

w = {1 => 3, 2 => 1, 3 => 2}
l = w.invert

rounds = input.split("\n").map { |r| r.split(" ").map { |h| hands[h] } }

puts rounds.reduce(0) { |acc, (a, b)|
  if a == b
    acc + 3 + b
  elsif w[b] == a
    acc + 6 + b
  else
    acc + b
  end
}

puts rounds.reduce(0) { |acc, (a, b)|
  case b
  when 1 then acc + w[a]
  when 2 then acc + 3 + a
  else        acc + 6 + l[a]
  end
}
