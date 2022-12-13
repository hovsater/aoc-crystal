PARSER = /Starting items: (?<items>[\d+, ]+)\s+Operation: (?<op>.+)\s+Test: (?<test>.+)\s+If true: throw to monkey (?<consequence>\d+)\s+If false: throw to monkey (?<alternative>\d+)/

INPUT = File.read("#{__DIR__}/day11.txt")

class Monkey
  getter test
  getter items
  getter inspection_count : Int64

  def initialize(@items : Array(Int64), @bin_op : {String, String, String}, @test : {Int64, Int64, Int64})
    @inspection_count = 0
  end

  def throw_items(relief)
    items.size.times do
      @inspection_count += 1

      item = inspect_item(items.shift) // relief

      if item % @test[0] == 0
        yield @test[1], item
      else
        yield @test[2], item
      end
    end
  end

  private def inspect_item(item)
    l = @bin_op[0].sub("old", item).to_i64
    r = @bin_op[2].sub("old", item).to_i64

    case @bin_op[1]
    when "*" then l * r
    when "+" then l + r
    when "-" then l + r
    else          item
    end
  end
end

def solve(rounds, relief)
  monkeys = [] of Monkey
  pos = 0
  while (m = INPUT.match(PARSER, pos))
    pos = m.byte_end
    items = m.named_captures["items"].not_nil!.split(", ").map(&.to_i64)
    l, op, r = m.named_captures["op"].not_nil!.sub("new = ", "").split(" ", 3)
    test = m.named_captures["test"].not_nil!.sub("divisible by ", "").to_i64
    consequence = m.named_captures["consequence"].not_nil!.to_i64
    alternative = m.named_captures["alternative"].not_nil!.to_i64
    monkeys.push(Monkey.new(items, {l, op, r}, {test, consequence, alternative}))
  end

  product = monkeys.product(&.test[0])

  rounds.times do |n|
    monkeys.each do |m|
      m.throw_items(relief) { |to, item| monkeys[to].items.push(item % product) }
    end
  end

  monkeys
end

puts solve(20, 3).map(&.inspection_count).sort.last(2).product
puts solve(10_000, 1).map(&.inspection_count).sort.last(2).product
