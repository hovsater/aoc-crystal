M = File.read_lines("#{__DIR__}/day08.txt").map(&.chars.map(&.to_i))

def in_direction(row, col, delta_row, delta_col)
  n = M[row][col]

  distance = 0
  visible = true
  while row > 0 && row < M.size - 1 && col > 0 && col < M[0].size - 1
    row += delta_row
    col += delta_col
    distance += 1
    if M[row][col] >= n
      visible = false
      break
    end
  end

  {visible, distance}
end

visible = M.size * 2 + (M[0].size - 2) * 2
scenic_score = 0
1.upto(M.size - 2).each do |row|
  1.upto(M[row].size - 2).each do |col|
    uv, ud = in_direction(row, col, -1, 0)
    dv, dd = in_direction(row, col, +1, 0)
    lv, ld = in_direction(row, col, 0, -1)
    rv, rd = in_direction(row, col, 0, +1)
    visible += 1 if {uv, dv, lv, rv}.any?
    score = ud * dd * ld * rd
    scenic_score = score if score > scenic_score
  end
end

puts visible
puts scenic_score
