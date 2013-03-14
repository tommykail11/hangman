class Hangman
	@tries_left = 8
	@blank = ""
	@game_lost = false
	@game_won = false

	def self.blank
		@blank
	end

	def self.blank=(blank)
		@blank = blank
	end

	def self.tries_left=(tries_left)
		@tries_left = tries_left
	end

	def self.tries_left
		@tries_left
	end

	def self.game_lost
		@game_lost
	end

	def self.game_won
		@game_won
	end
	
	def self.select_random_word
		dictionary = ["ruby", "rails", "monk", "monkey", "ridiculous", "luscious", "moist", "asscrack"]
		dictionary.sample
	end

	def self.make_blank(word)
		@blank = "_" * word.length
	end

	def self.letter_check(letter, word)
		word.include?(letter)
	end

	def self.outcome(result, letter, word)
		if result
			@blank = self.new_blank(letter, word)
			return "You guessed correctly!"
		else
			@tries_left -= 1
			return "You have #{@tries_left} tries left."
		end
	end

	def self.find_letter_positions(guessed_letter, word)
		index_array = []
		word.split("").each_with_index { |letter, index| index_array << index if letter == guessed_letter }
		index_array
	end

	def self.put_letters_into_blank(guessed_letter, index_array)
		blank_array = @blank.split("") 
		(0...blank_array.length).each do |blank_index|
			if index_array.include?(blank_index)
				blank_array[blank_index] = guessed_letter
			end
		end
		blank_array.join("")
	end

	def self.new_blank(guessed_letter, word)
		index_array = self.find_letter_positions(guessed_letter, word)
		self.put_letters_into_blank(guessed_letter, index_array)
	end

	def self.lost?(number)
		@game_lost = true if number <= 0
	end

	def self.won?(blank)
		@game_won = true if !blank.include?("_")
	end

	def self.initialize()
		word = self.select_random_word
		self.make_blank(word)
		while @game_lost == false && @game_won == false
				puts "This is the word: #{@blank}. Guess a letter."
				letter = gets.chomp
				result = self.letter_check(letter, word)
				puts self.outcome(result, letter, word)
				Hangman.lost?(Hangman.tries_left)
				Hangman.won?(@blank)
		end
		puts "You won the game." if @game_won
		puts "You lost to a computer. Wow." if @game_lost
	end

end