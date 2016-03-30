require 'Set'
# Implements a Boggle game that can solve itself
class Boggle
  def initialize(board)
    @num_rows = board.length
    @num_columns = board.first.length
    @board = board
    @words = Set.new
    @dictionary = Set.new
    File.open('dictionary.txt', 'r').each_line do |line|
      @dictionary.add(line.strip)
    end
  end

  def solve
    visited = Array.new(@num_rows) { Array.new(@num_columns) { false } }
    (0...@num_rows).each do |x|
      (0...@num_columns).each do |y|
        find_words(visited, x, y, '')
      end
    end
    @words
  end

  private

  def find_words(visited, row, column, candidate)
    visited[row][column] = true
    candidate << @board[row][column]
    @words.add(candidate) if valid_word? candidate
    (row - 1..row + 1).each do |x|
      (column - 1..column + 1).each do |y|
        find_words(visited, x, y, candidate) unless invalid_space?(x, y, row, column, visited)
      end
    end
    candidate.chop!
    visited[row][column] = false
  end

  def valid_word?(candidate)
    @dictionary.include? candidate
  end

  def invalid_space?(x, y, row, column, visited)
    out_of_bounds?(x, y) || visited[x][y] || current_cell?(x, y, row, column)
  end

  def out_of_bounds?(x, y)
    x < 0 || y < 0 || x >= @num_rows || y >= @num_columns
  end

  def current_cell?(x, y, row, column)
    x == row && y == column
  end
end
