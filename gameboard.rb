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







