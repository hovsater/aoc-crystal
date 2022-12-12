instructions = File.read_lines("#{__DIR__}/day10.txt").map do |line|
  case line
  when .starts_with?("addx")
    _, amount = line.split(" ")
    {2, amount.to_i}
  else
    {1, 0}
  end
end

def run(instructions)
  x = 1
  cycle = 1

  while instructions.size > 0
    yield cycle, x

    count, amount = instructions[0]

    if count - 1 != 0
      instructions[0] = {count - 1, amount}
    else
      instructions.shift
      x += amount
    end

    cycle += 1
  end
end

signal_strength_sum = 0
crt = Array.new(6) { Array.new(40, ".") }

run(instructions) do |cycle, x|
  signal_strength_sum += x * cycle if [20, 60, 100, 140, 180, 220].includes?(cycle)
  crt[(cycle - 1) // 40][(cycle - 1) % 40] = "#" if ((cycle - 1) % 40).in?(x - 1..x + 1)
end

puts signal_strength_sum
crt.each { |r| r.each { |c| print c }; puts }
