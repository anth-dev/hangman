# frozen_string_literal: true

# When a game is started load the dictionary and randomly select a word between
# 5 and 12 characters long to be the secret word.
def pick_random_word
  picked = File.readlines('5desk.txt').sample
  picked.length.between?(5,12) ? picked : pick_random_word
end

# Display the correct letters that have already been choosen and their position
# in the hidden word along with any that have already been choosen (ex. r_b_).
# For each incorrect guess draw one part, have the display draw one part of the
# person. In the display method have the default values for those spaces be ' '.
#
# ------------------------------------------
# |   |   | enter 'save' to save your game |
# |   O   |--------------------------------|
# |  \|/  |                                |
# |   |   |                                |
# |  / \  |--------------------------------|
# |       |                                |
# ------------------------------------------
# >
#
# ------------------------------------------
# |       | enter 'save' to save your game |
# |       |--------------------------------|
# |       |                                |
# |       |                                |
# |       |--------------------------------|
# |       |                                |
# ------------------------------------------
# >
def display_game
  system 'clear'

  interface = <<~INTERFACE
    ------------------------------------------
    |   |   | enter 'save' to save your game |
    |   O   |--------------------------------|
    |  \\|/  |                                |
    |   |   |                                |
    |  / \\  |--------------------------------|
    |       |#{reveal_correct}|
    ------------------------------------------
  INTERFACE

  puts interface
end

def reveal_correct
  # The following string is just for testing the display.
  string = '_ _ c _ _ _'
  string.center(32)
end

# Each turn have the player guess a letter (case insensitive) and then display
# whether it was correct or not. If the player is out of guesses then they loose
# they game.

# Implement the ability to save the game at the start of the player's turn.

# When the program is openeed add an option to load one of your saved games.

display_game
