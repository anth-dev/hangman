# frozen_string_literal: true

# This class creates Hangman games.
class HangmanGame
  def initialize
    @incorrect_guesses = 0
    @secret_word = pick_random_word
    @head = ' '
    @neck = ' '
    @left_arm = ' '
    @right_arm = ' '
    @torso = ' '
    @left_leg = ' '
    @right_leg = ' '
    @rope = ' '
  end

  # Here is the logic that runs the game
  def start_game
    # Each turn have the player guess a letter (case insensitive) and then display
    # whether it was correct or not. If the player is out of guesses then they loose
    # they game.
    puts "we are calling the start game method!"
    puts "The secret word is: #{@secret_word}"
    
  end

  private

  # When a game is started load the dictionary and randomly select a word between
  # 5 and 12 characters long to be the secret word.
  def pick_random_word
    picked = File.readlines('5desk.txt').sample
    picked.length.between?(5, 12) ? picked : pick_random_word
  end

  def display_game
    # Set which body parts to draw.
    set_body_parts_to_display

  
    system 'clear'
  
    interface = <<~INTERFACE
      ------------------------------------------
      |   #{@rope}   | enter 'save' to save and quit  |
      |   #{@head}   |--------------------------------|
      |  #{@right_arm}#{@neck}#{@left_arm}  |                                |
      |   #{@torso}   |                                |
      |  #{@right_leg} #{@left_leg}  |--------------------------------|
      |       |#{reveal_correct}|
      ------------------------------------------
    INTERFACE
  
    puts interface
  end

  def set_body_parts_to_display
    # Set the body parts to draw based on the number of incorrect guesses made.
    @head = '0' if @incorrect_guesses >= 1
    @neck = '|' if @incorrect_guesses >= 2
    @left_arm = '/' if @incorrect_guesses >= 3
    @right_arm = '\\' if @incorrect_guesses >= 4
    @torso = '|' if @incorrect_guesses >= 5
    @left_leg = '\\' if @incorrect_guesses >= 6
    @right_leg = '/' if @incorrect_guesses >= 7
    @rope = '|' if @incorrect_guesses >= 8
  end

  
  def reveal_correct
    # The following string is just for testing the display.
    string = '_ _ c _ _ _'
    string.center(32)
  
    # Here we need to compare the secret word with the guessed letters to return
    # a string that shows what letters were right and where they go in the secret
    # word. Any that have not been guessed will be represented as an underscore.
  
  end
end

# Implement the ability to save the game at the start of the player's turn.


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
    # Generate a new game object.
    game = HangmanGame.new

    # Start a new game. ** NEED TO MAKE THE METHOD **
    game.start_game
  when '2'
    # Load a saved game.
  when '3'
    # Quit the game.
    exit
  else
    display_menu
  end
end

display_menu
