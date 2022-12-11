M = File.read_lines("#{__DIR__}/day08.txt").map(&.chars.map(&.to_i))

def visible_dir?(row, col, delta_row, delta_col)
  n = M[row][col]

  while row > 0 && row < M.size - 1 && col > 0 && col < M[0].size - 1
    row += delta_row
    col += delta_col
    return false if M[row][col] >= n
  end

  true
end

def score_dir(row, col, delta_row, delta_col)
  n = M[row][col]
  p = 0

  while row > 0 && row < M.size - 1 && col > 0 && col < M[0].size - 1
    row += delta_row
    col += delta_col
    p += 1
    break if M[row][col] >= n
  end
  p
end

visible = M.size * 2 + (M[0].size - 2) * 2
scenic_score = 0
1.upto(M.size - 2).each do |row|
  1.upto(M[row].size - 2).each do |col|
    visible += 1 if visible_dir?(row, col, -1, 0) || visible_dir?(row, col, 1, 0) || visible_dir?(row, col, 0, -1) || visible_dir?(row, col, 0, 1)
    score = score_dir(row, col, -1, 0) * score_dir(row, col, 1, 0) * score_dir(row, col, 0, -1) * score_dir(row, col, 0, 1)
    scenic_score = score if score > scenic_score
  end
end

puts visible
puts scenic_score
