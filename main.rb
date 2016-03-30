require './boggle'

board = [%w(c a t s), %w(n o t e), %w(b a s e)]
boggle = Boggle.new(board)
boggle.solve.each { |word| puts word }
