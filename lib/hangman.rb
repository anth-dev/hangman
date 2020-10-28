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
  # to draw. These are probably better moved to a different method and have the
  # incorrect_guesses instead be an instance variable once the class is made
  # for the game.
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
    |   #{rope}   | enter 'save' to save and quit  |
    |   #{head}   |--------------------------------|
    |  #{right_arm}#{neck}#{left_arm}  |                                |
    |   #{torso}   |                                |
    |  #{right_leg} #{left_leg}  |--------------------------------|
    |       |#{reveal_correct}|
    ------------------------------------------
  INTERFACE

  puts interface
end

# This displays the game menu when the game is ran. It should give the player
# the following options: New Game, Load Game, and Quit.
def display_menu
  system 'clear'
  
  interface = <<~INTERFACE
    ------------------------------------------
    |#{'Welcome to Hangman'.center(40)}|
    |                                        |
    |#{'1. New Game'.center(40)}|
    |#{'2. Load Game'.center(40)}|
    |#{'3. Quit     '.center(40)}|
    |                                        |
    ------------------------------------------
    >
  INTERFACE

  puts interface
  handle_menu_selection
end

def handle_menu_selection
  selection = gets.chomp
  case selection
  when '1'
    # Start a new game.
  when '2'
    # Load a saved game.
  when '3'
    # Quit the game.
    exit
  else
    display_menu
  end
end

def reveal_correct
  # The following string is just for testing the display.
  string = '_ _ c _ _ _'
  string.center(32)

  # Here we need to compare the secret word with the guessed letters to return
  # a string that shows what letters were right and where they go in the secret
  # word. Any that have not been guessed will be represented as an underscore.
end

# Each turn have the player guess a letter (case insensitive) and then display
# whether it was correct or not. If the player is out of guesses then they loose
# they game.

# Implement the ability to save the game at the start of the player's turn.

# When the program is openeed add an option to load one of your saved games.

display_menu
