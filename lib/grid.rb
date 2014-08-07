class Grid
  def initialize(grid)
    @grid = grid
    @size = grid.length - 1
  end

  def tick
    y = 0
    x = 0

    # Duplication of the array of arrays before cells change.
    new_grid = Marshal.load( Marshal.dump(@grid))

    @grid.each do |row|
      row.each do |cell|
        alive_neighbors = neighbors(x,y)
        alive = cell
        new_grid[x][y] = cell_change(alive_neighbors, alive)
        y += 1
      end
      y = 0
    x += 1
    end
    new_grid
  end

  def cell_change(neighbors, alive)

    alive == 1 && (neighbors == 2 || neighbors == 3) ? alive = 1 : nil
    alive == 0 && neighbors == 3 ? alive = 1 : nil
    neighbors < 2 ? alive = 0 : nil
    neighbors > 3 ? alive = 0 : nil

    alive
  end

  def neighbors(row,col)
    alive_cells = 0

    # Row - 1
    # ======================================================
    row > 0 && col < @size && (@grid[row-1][col+1] == 1) ? alive_cells += 1 : nil
    row > 0 && col > 0 && (@grid[row-1][col-1] == 1) ? alive_cells += 1 : nil
    row > 0 && (@grid[row-1][col] == 1) ? alive_cells += 1 : nil

    # Row + 0
    # ======================================================
    col < @size && (@grid[row][col+1] == 1) ? alive_cells += 1 : nil
    col > 0 && (@grid[row][col-1] == 1) ? alive_cells += 1 : nil

    # Row + 1
    # ======================================================
    row < @size && col < @size && (@grid[row+1][col+1] == 1) ? alive_cells += 1 :nil
    row < @size && col > 0 && (@grid[row+1][col-1] == 1) ? alive_cells += 1 :nil
    row < @size && (@grid[row+1][col] == 1) ? alive_cells += 1 :nil

    alive_cells
  end
end