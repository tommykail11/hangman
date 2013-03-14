require "test/unit"
require_relative "hangman"

class HangmanTest < Test::Unit::TestCase

	def test_select_word
		dictionary = ["ruby", "rails", "monk", "monkey", "ridiculous", "luscious", "moist", "asscrack"]
		assert_equal true, dictionary.include?(Hangman.get_word)
	end

	def test_blank_word
		assert_equal "______", Hangman.make_word_blank("string")
	end

	def test_guess_letter
		assert_equal true, Hangman.check_word_has_letter("t", "train")
		assert_equal false, Hangman.check_word_has_letter("z", "brain")
	end

	def test_answer
		Hangman.outcome(false, "l", "bear")
		assert_equal "You have 7 tries left.",  "You have #{Hangman.tries_left} tries left."
		assert_equal "You guessed correctly!", Hangman.outcome(true, "n", "nothing")
	end

	def test_if_correct_letter_positions_found
		assert_equal [3, 6], Hangman.find_where_letter_is_in_word("c", "asscrack")
		assert_equal [], Hangman.find_where_letter_is_in_word("b", "montreal")
	end

	def test_if_blanks_are_filled_with_letters
		Hangman.blank = "_____"
		assert_equal "_ll__", Hangman.put_letter_into_blank_where_it_was_in_word("l", [1, 2])
	end

	def test_if_blank_renews
		Hangman.blank = "_____"
		assert_equal "_ll__", Hangman.put_letter_into_blank("l", "allow")
	end

	def test_if_tries_run_out
		Hangman.tries_left = 0
		Hangman.game_lost?(Hangman.tries_left)
		assert_equal true, Hangman.game_lost
	end

	def test_if_full_word_is_guessed
		Hangman.blank = "motorcycle"
		Hangman.game_won?(Hangman.blank)
		assert_equal true, Hangman.game_won
	end
end
