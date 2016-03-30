require 'pry'
# Extends string class. Needs to be done with dictionary.
class String
  def valid_word?
    self == 'cat' || self == 'car' || self == 'cz' || self == 'ac'
  end
end

# Implements a Boggle game that can solve itself
class Boggle
  def initialize(board)
    @n_rows = board.length
    @n_columns = board.first.length
    @board = board
  end

  def solve
    visited = Array.new(@n_rows) { Array.new(@n_columns) { false } }
    candidate = ''
    (0...@n_rows).each do |x|
      (0...@n_columns).each do |y|
        find_words(@board, visited, x, y, candidate)
      end
    end
  end

  private

  def find_words(board, visited, row, column, candidate)
    visited[row][column] = true
    candidate << board[row][column]
    puts candidate if candidate.valid_word?
    (row - 1..row + 1).each do |x|
      (column - 1..column + 1).each do |y|
        find_words(board, visited, x, y, candidate) unless invalid_space?(x, y, row, column, visited)
      end
    end
    candidate.chop!
    visited[row][column] = false
  end

  def invalid_space?(x, y, row, column, visited)
    out_of_bounds?(x, y) || visited?(x, y, visited) || current?(x, y, row, column)
  end

  def out_of_bounds?(x, y)
    x == -1 || y == -1 || x >= @n_rows || y >= @n_columns
  end

  def visited?(x, y, visited)
    visited[x][y]
  end

  def current?(x, y, row, column)
    x == row && y == column
  end
end

board = [%w(c a t), %w(a z z), %w(r z z)]
boggle = Boggle.new(board)
boggle.solve
