class GameBoard
	attr_accessor :a, :b, :c, :d, :e, :f, :g, :h, :i

	def initialize
		default_space
	end

	def display
		puts "\n#{a}|#{b}|#{c}\n---+---+---\n#{d}|#{e}|#{f}\n---+---+---\n#{g}|#{h}|#{i}\n"
	end

	def key
		puts "\n a | b | c \n---+---+---\n d | e | f \n---+---+---\n g | h | i \n"
	end

	def default_space
		("a".."i").each { |x| self.send("#{x}=", empty_space) }
	end

	def empty_space
		"   "
	end

	def place_x( key )
		self.send("#{key}") == empty_space ? (self.send("#{key}=", " X ")):(occupied(:place_x))
	end

	def place_o( key )
		self.send("#{key}") == empty_space ? (self.send("#{key}=", " O ")):(occupied(:place_o))
	end

	def occupied( method )
		puts "That spot is already taken!"
		print "Please select another key "
		key = gets.chomp
		self.send(method, key)
	end

	def winning_combinations
		[[a, b, c], [d, e, f], [g, h, i], [a, e, i], [g, e, c], [a, d, g], [b, e, h], [c, f, i]]
	end

	def scan_for_winner
		winning_combinations.select { |x| !x.include? empty_space }.map { |x| x.uniq.count == 1 }
	end

	def winner?
		scan_for_winner.include? true ? true:false
	end

	def scan_for_draw
		winning_combinations.flatten.count(empty_space)
	end

	def draw?
		scan_for_draw == 0 
	end
end

class Player
	attr_reader   :player1, :player2, :gameboard, :turn_order

	def initialize( args = {} )
		@player1    = args[:player1] || "player1"
		@player2    = args[:player2] || "player2" 
		@turn_order = [player1, player2]
		@gameboard  = GameBoard.new
	end

	def switch_players
		turn_order[0], turn_order[1] = turn_order[1], turn_order[0]
	end

	def game_info
		gameboard.display
		gameboard.key
		puts ""
	end

	def end_game?
		gameboard.winner? || gameboard.draw?
	end

	def end_message
		puts gameboard.winner? ? "#{current_player} has won the game!" : "The game has ended in a draw" 
	end

	def play_again?
		print "Do you want to play again? (y/n) "
		answer = gets.chomp
		answer == "y" ? (gameboard = GameBoard.new; gameboard.default_space; start_game) : (exit)
	end

	def current_player
		turn_order.first
	end

	def make_move( player, turn )
		print "ok #{player}! Make your move : "
		move = gets.chomp
		turn.even? ? (gameboard.place_x(move)):(gameboard.place_o(move))
	end

	def start_game
		turn = 1
		until end_game?
			game_info
			switch_players
			make_move(current_player, turn)
			turn += 1
		end
		end_message
		play_again?
	end
end





