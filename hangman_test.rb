require "test/unit"
require_relative "hangman"

class HangmanTest < Test::Unit::TestCase

	def test_select_word
		dictionary = ["ruby", "rails", "monk", "monkey", "ridiculous", "luscious", "moist", "asscrack"]
		assert_equal true, dictionary.include?(Hangman.select_random_word)
	end

	def test_blank_word
		assert_equal "______", Hangman.make_blank("string")
	end

	def test_guess_letter
		assert_equal true, Hangman.letter_check("t", "train")
		assert_equal false, Hangman.letter_check("z", "brain")
	end

	def test_answer
		Hangman.outcome(false, "l", "bear")
		assert_equal "You have 7 tries left.",  "You have #{Hangman.tries_left} tries left."
		assert_equal "You guessed correctly!", Hangman.outcome(true, "n", "nothing")
	end

	def test_if_correct_letter_positions_found
		assert_equal [3, 6], Hangman.find_letter_positions("c", "asscrack")
		assert_equal [], Hangman.find_letter_positions("b", "montreal")
	end

	def test_if_blanks_are_filled_with_letters
		Hangman.blank = "_____"
		assert_equal "_ll__", Hangman.put_letters_into_blank("l", [1, 2])
	end

	def test_if_blank_renews
		Hangman.blank = "_____"
		assert_equal "_ll__", Hangman.new_blank("l", "allow")
	end

	def test_if_tries_run_out
		Hangman.tries_left = 0
		Hangman.lost?(Hangman.tries_left)
		assert_equal true, Hangman.game_lost
	end

	def test_if_full_word_is_guessed
		Hangman.blank = "motorcycle"
		Hangman.won?(Hangman.blank)
		assert_equal true, Hangman.game_won
	end
end
