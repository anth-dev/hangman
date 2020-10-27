# frozen_string_literal: true

# When a game is started load the dictionary and randomly select a word between
# 5 and 12 characters long to be the secret word.
def pick_random_word
  picked = File.readlines('5desk.txt').sample
  picked.length.between?(5,12) ? picked : pick_random_word
end

# Display a count that shows the how many incorrect guesses are left before the
# game will end. Also display the correct letters that have already been choosen
# and their position in the hidden word along with any that have already been
# choosen. (ex. r_b_)
def display_game(secret_word, previous_guesses, remaining_turns)
  system 'clear'
  # Example of the interface
  # | Remaining: 9 | ru_y |
  puts "| Remaining: #{remaining_turns} | #{reveal_correct(secret_word, previous_guesses)} |"
end

def reveal_correct(secret_word, previous_guesses)
  # The following string is just for testing.
  '_ _ c _ _ _'
end

# Each turn have the player guess a letter (case insensitive) and then display
# whether it was correct or not. If the player is out of guesses then they loose
# they game.

# Implement the ability to save the game at the start of the player's turn.

# When the program is openeed add an option to load one of your saved games.

display_game('secret', ['a', 'b', 'c'], 8)