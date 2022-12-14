record Tile, x : Int32, y : Int32, value : Char

input = File.read_lines("#{__DIR__}/day12.txt")
grid = Array.new(input.size) { Array(Tile).new(input[0].size) }
start_tile = nil
end_tile = nil

input.each_with_index do |row, i|
  row.each_char_with_index do |col, j|
    case col
    when 'S'
      start_tile = Tile.new(j, i, 'a')
      grid[i].push(start_tile)
    when 'E'
      end_tile = Tile.new(j, i, 'z')
      grid[i].push(end_tile)
    else grid[i].push(Tile.new(j, i, col))
    end
  end
end

def bfs(grid, start_tile, end_tile)
  queue = Deque(Tile).new(grid.size * grid[0].size)
  queue.push(start_tile)
  came_from = {} of Tile => Tile | Nil
  came_from[start_tile] = nil

  while queue.size > 0
    current = queue.shift

    break if current == end_tile

    neighbours = [{0, -1}, {0, 1}, {-1, 0}, {1, 0}].map do |x, y|
      nx = current.x + x
      ny = current.y + y
      grid[ny][nx] if ny.in?(0...grid.size) && nx.in?(0...grid[0].size) && current.value + 1 >= grid[ny][nx].value
    end.compact

    neighbours.each do |neighbour|
      unless came_from.has_key?(neighbour)
        queue.push(neighbour)
        came_from[neighbour] = current
      end
    end
  end

  return nil unless came_from.has_key?(end_tile)

  path_size = 0
  current = end_tile
  while current != start_tile
    path_size += 1
    current = came_from[current]
  end

  path_size
end

puts bfs(grid, start_tile.not_nil!, end_tile.not_nil!)
puts grid.flat_map { |r| r.select { |t| t.value == 'a' } }.map { |start_tile| bfs(grid, start_tile, end_tile) }.compact.min
