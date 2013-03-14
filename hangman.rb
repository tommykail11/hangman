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
	
	def self.get_word
		dictionary = ["ruby", "rails", "monk", "monkey", "ridiculous", "luscious", "moist", "asscrack"]
		dictionary.sample
	end

	def self.make_word_blank(word)
		@blank = "_" * word.length
	end

	def self.check_word_has_letter(letter, word)
		word.include?(letter)
	end

	def self.outcome(result, letter, word)
		if result
			@blank = self.put_letter_into_blank(letter, word)
			return "You guessed correctly!"
		else
			@tries_left -= 1
			return "You have #{@tries_left} tries left."
		end
	end

	def self.find_where_letter_is_in_word(guessed_letter, word)
		index_array = []
		word.split("").each_with_index { |letter, index| index_array << index if letter == guessed_letter }
		index_array
	end

	# This method's name should be more concise.
	def self.put_letter_into_blank_where_it_was_in_word(letter, index_array)
		blank_array = @blank.split("") 
		(0...blank_array.length).each do |blank_index|
			if index_array.include?(blank_index)
				blank_array[blank_index] = letter
			end
		end
		blank_array.join("")
	end

	def self.put_letter_into_blank(guessed_letter, word)
		index_array = self.find_where_letter_is_in_word(guessed_letter, word)
		self.put_letter_into_blank_where_it_was_in_word(guessed_letter, index_array)
	end

	def self.game_lost?(number)
		@game_lost = true if number <= 0
	end

	def self.game_won?(blank)
		@game_won = true if !blank.include?("_")
	end

	def self.initialize()
		word = self.get_word
		self.make_word_blank(word)
		while @game_lost == false && @game_won == false
				puts "This is the word: #{@blank}. Guess a letter."
				letter = gets.chomp
				result = self.check_word_has_letter(letter, word)
				puts self.outcome(result, letter, word)
				Hangman.game_lost?(Hangman.tries_left)
				Hangman.game_won?(@blank)
		end
		puts "You won the game." if @game_won
		puts "You lost to a computer. Wow." if @game_lost
	end

end