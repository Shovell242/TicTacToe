require_relative "gameboard"

class Player
	attr_reader   :player1, :player2, :gameboard, :turn_order, :wins

	def initialize( args = {} )
		@player1    = args[:player1] || "player1"
		@player2    = args[:player2] || "player2" 
		@turn_order = [player1, player2]
		@wins       = Hash.new(0)
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

	def win_total( current_player )
		wins[current_player] += 1
	end

	def display_wins
		wins.each { |player, wins| print "#{player} has a win total of #{wins}! "}
	end

	def end_message
		puts gameboard.winner? ? "#{current_player} has won the game!" : "The game has ended in a draw" 
		win_total( current_player) if gameboard.winner?
	end

	def play_again?
		print "Would you like to play again? (y/n) : "
		answer = gets.chomp
		if answer == "y"
			gameboard.default_space
			gameboard = GameBoard.new
			start_game
		else
			exit
		end
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
		display_wins
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