class Grid
  def initialize(grid)
    @grid = grid
    @size = grid.length - 1
  end

  def tick
    col = 0
    row = 0

    new_grid = Marshal.load( Marshal.dump(@grid))

    @grid.each do |rows|
      rows.each do |columns|
        alive_neighbors = neighbors(row,col)
        alive = columns
        new_grid[row][col] = cell_change(alive_neighbors, alive)
        col += 1
      end
      col = 0
    row += 1
    end
    # p new_grid
    # p grid
    new_grid
  end

  def cell_change(neighbors, alive)
    if alive == 1 && (neighbors == 2 || neighbors == 3)
      alive = 1
    end
    if neighbors < 2
      alive = 0
    end
    if neighbors > 3
      alive = 0
    end
    if alive == 0 && neighbors == 3
      alive = 1
    end

    alive
  end

  def neighbors(row,col)
    alive_cells = 0

    # Row - 1
    # ======================================================
    if row > 0 && col > 0 && (@grid[row-1][col-1] == 1)
      alive_cells += 1
    end
    if row > 0 && (@grid[row-1][col] == 1)
      alive_cells += 1
    end
    if row > 0 && col < @size && (@grid[row-1][col+1] == 1)
      p "r-1, c+1"
      alive_cells += 1
    end
    # Row + 0
    # ======================================================
    if col > 0 && (@grid[row][col-1] == 1)
      alive_cells += 1
    end
    if col < @size && (@grid[row][col+1] == 1)
      alive_cells += 1
    end
    # Row + 1
    # ======================================================
    if row < @size && col > 0 && (@grid[row+1][col-1] == 1)
      alive_cells += 1
    end
    if row < @size && (@grid[row+1][col] == 1)
      alive_cells += 1
    end
    if row < @size && col < @size && (@grid[row+1][col+1] == 1)
      p "r+1, c+1"

      alive_cells += 1
    end
    p "alive neigh #{alive_cells}"
    alive_cells
  end
  
end