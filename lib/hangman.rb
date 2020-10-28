# frozen_string_literal: true

# When a game is started load the dictionary and randomly select a word between
# 5 and 12 characters long to be the secret word.
def pick_random_word
  picked = File.readlines('5desk.txt').sample
  picked.length.between?(5, 12) ? picked : pick_random_word
end

# Display the correct letters that have already been choosen and their position
# in the hidden word along with any that have already been choosen (ex. r_b_).
# For each incorrect guess draw one body part have the display draw one part.
# In the display method have the default values for those spaces be ' '.
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
def display_game(incorrect_guesses)
  # The following variables are for letting the display know what person pieces
  # to draw.
  head = incorrect_guesses >= 1 ? 'O' : ' '
  neck = incorrect_guesses >= 2 ? '|' : ' '
  left_arm = incorrect_guesses >= 3 ? '/' : ' '
  right_arm = incorrect_guesses >= 4 ? '\\' : ' '
  torso = incorrect_guesses >= 5 ? '|' : ' '
  left_leg = incorrect_guesses >= 6 ? '\\' : ' '
  right_leg = incorrect_guesses >= 7 ? '/' : ' '
  rope = incorrect_guesses >= 8 ? '|' : ' '

  system 'clear'

  interface = <<~INTERFACE
    ------------------------------------------
    |   #{rope}   | enter 'save' to save your game |
    |   #{head}   |--------------------------------|
    |  #{right_arm}#{neck}#{left_arm}  |                                |
    |   #{torso}   |                                |
    |  #{right_leg} #{left_leg}  |--------------------------------|
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

display_game(0)
