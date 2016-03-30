# Implements a Boggle game that can solve itself
class Boggle
  def initialize(board)
    @n_rows = board.length
    @n_columns = board.first.length
    @board = board
    @words = Set.new
    @dictionary = Set.new
    File.open('dictionary.txt', 'r') do |f|
      f.each_line do |line|
        @dictionary.add(line.strip)
      end
    end
  end

  def solve
    visited = Array.new(@n_rows) { Array.new(@n_columns) { false } }
    candidate = ''
    (0...@n_rows).each do |x|
      (0...@n_columns).each do |y|
        find_words(@board, visited, x, y, candidate)
      end
    end
    @words
  end

  private

  def find_words(board, visited, row, column, candidate)
    visited[row][column] = true
    candidate << board[row][column]
    @words.add(candidate) if valid_word?(candidate)
    (row - 1..row + 1).each do |x|
      (column - 1..column + 1).each do |y|
        find_words(board, visited, x, y, candidate) unless invalid_space?(x, y, row, column, visited)
      end
    end
    candidate.chop!
    visited[row][column] = false
  end

  def valid_word?(candidate)
    @dictionary.include?(candidate)
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

board = [%w(c a t s), %w(n o t e), %w(b a s e)]
boggle = Boggle.new(board)
boggle.solve.each do |word|
  puts word
end
