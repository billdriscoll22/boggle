require 'pry'

class String
  def valid_word?
    self == 'cat' || self == 'car' || self == 'cz' || self == 'ac'
  end
end

class Boggle

  def initialize(boggle_grid)
    @n_rows = boggle_grid.length
    @n_columns = boggle_grid.first.length
    @boggle_grid = boggle_grid
  end

  def solve
    visited_grid = Array.new(@n_rows) { Array.new(@n_columns) }
    candidate = ""
    for x in (0...@n_rows)
      for y in (0...@n_columns)
        find_words(@boggle_grid, visited_grid, x, y, candidate)
      end
    end
  end

  private

  def find_words(boggle_grid, visited_grid, row, column, candidate)
    visited_grid[row][column] = true
    candidate << boggle_grid[row][column]
    puts candidate if candidate.valid_word?
    (row - 1..row + 1).each do |x|
      (column - 1..column + 1).each do |y|
        find_words(boggle_grid, visited_grid, x, y, candidate) unless
                                        x == -1 || y == -1 || x >= @n_rows ||
                                        y >= @n_columns || visited_grid[x][y] ||
                                        (x == row && y == column)
      end
    end
    candidate.chop!
    visited_grid[row][column] = false
  end
end

boggle_grid = [%w(c a t), %w(a z z), %w(r z z)]
boggle = Boggle.new(boggle_grid)
boggle.solve()
