class Hangman
	@tries_left = 8
	@blank = ""

	# def self.tries_left=(num)
	# 	@tries_left = num
	# end

	def self.tries_left
		@tries_left
	end
	
	def self.select_random_word
		dictionary = ["ruby", "rails", "monk", "monkey", "ridiculous", "luscious", "moist", "asscrack"]
		dictionary.sample
	end

	def self.make_blank(word)
		blank = "_" * word.length
		blank
	end

	def self.letter_check(letter, word)
		word.include?(letter)
	end

	def self.outcome(result)
		if result
			# we'll put it here
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

	def self.put_letters_into_blank(blank, guessed_letter, index_array)
		blank = blank.split("") 
		(0...blank.length).each do |blank_index|
			if index_array.include?(blank_index)
				blank[blank_index] = guessed_letter
			end
		end
		blank.join("")
	end

	def self.new_blank(guessed_letter, word, blank)
		index_array = self.find_letter_positions(guessed_letter, word)
		self.put_letters_into_blank(blank, guessed_letter, index_array)
	end

	def self.initialize()
		word = self.select_random_word
		blank = self.make_blank(word)
	end

# to do:
# • change from self to Hangman.new

end