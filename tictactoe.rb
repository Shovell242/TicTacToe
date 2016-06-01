class GameBoard
	attr_accessor :a, :b, :c, :d, :e, :f, :g, :h, :i

	def display
		puts " #{a} | #{b} | #{c}\n" + 
		     " --------\n" +
		     " #{d} | #{e} | #{f}\n" +
		     " --------\n" +
		     " #{g} | #{h} | #{i}"
	end

	def key
		puts " a | b | c\n d | e | f\n g | h | i"
	end

	def place_x( key )
		self.send("#{key}").nil? ? (self.send("#{key}=", "X")):(puts "Sorry that spot is already taken!")
	end

	def place_o( key )
		self.send("#{key}").nil? ? (self.send("#{key}=", "O")):(puts "Sorry that spot is already taken!")
	end

	def winning_combinations
		[[a, b, c], [d, e, f], [g, h, i], [a, e, i], [g, e, c], [a, d, g], [b, e, h], [c, f, i]]
	end

	def scan_for_winner
		winning_combinations.select { |x| !x.include? nil }.map { |x| x.uniq.count == 1 }
	end

	def winner?
		scan_for_winner.include? true ? true:false
	end
end

class Player
	attr_reader   :player1, :player2, :gameboard

	def initialize( args = {} )
		@player1    = args[:player1] || "player1"
		@player2    = args[:player2] || "player2" 
		@gameboard  = GameBoard.new
	end

	def first_move
		print "#{player1} please select a key to place your X "
		move = gets.chomp
	 	gameboard.place_x(move)
	end

	def second_move
		print "#{player2} please select a key to place your O "
		move = gets.chomp
		gameboard.place_o(move)
	end

	def game_info
		gameboard.display
		gameboard.key
	end

	def begin_game
		puts "#{player1} will use X's, while #{player2} will use O's"

		until gameboard.winner?
			 game_info
			 first_move
			 game_info
			 second_move
		end
	end
end





