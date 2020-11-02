# frozen_string_literal: true

require 'pry'

# This class creates Hangman games.
class HangmanGame
  def initialize
    @incorrect_guesses = 0
    @previous_guesses = []
    @secret_word = pick_random_word
    @guess_feedback = create_blank_feedback_array
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
  def take_turn
    # Each turn have the player guess a letter (case insensitive) and then display
    # whether it was correct or not. If the player is out of guesses then they loose
    # they game.
    display_game
    print '>'

    # Get, and handle input from the player.
    handle_player_guess

    # Check for win/loss.
    check_for_win_or_lose

    # If they haven't won or lost, continue!
    take_turn
  end

  private

  # When a game is started load the dictionary and randomly select a word between
  # 5 and 12 characters long to be the secret word. The format of the word should
  # be an array of characters.
  def pick_random_word
    picked = File.readlines('5desk.txt').sample
    picked.length.between?(5, 12) ? picked.downcase.chomp.chars : pick_random_word
  end

  def display_game
    # Set which body parts to draw.
    set_body_parts_to_display

    system 'clear'
  
    interface = <<~INTERFACE
      ------------------------------------------
      |   #{@rope}   |#{@previous_guesses.join(' ').center(32)}|
      |   #{@head}   |--------------------------------|
      |  #{@right_arm}#{@neck}#{@left_arm}  |#{"Enter 'save' to save and quit.".center(32)}|
      |   #{@torso}   |#{'Otherwise guess a letter!'.center(32)}|
      |  #{@right_leg} #{@left_leg}  |--------------------------------|
      |       |#{@guess_feedback.join(' ').center(32)}|
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

  
  def create_blank_feedback_array
    # Iterate over the secret word array with map or each. For each element
    # push an underscore to the feedback array. OR possibly just map the array
    # changing the value to an underscore and return that array???
    @secret_word.map { |character| character = '_' }
  end

  def handle_player_guess
    # Get input from the player.
    guess = gets.chomp.downcase
    
    # Check to see if they are trying to save. Later on change the puts
    # to call the method that will save the game state and exit the game.
    puts 'trying to save' if guess == 'save'

    # Check the guess to make sure it's only one character and only contains
    # letters. If either is false, start the player's turn over.
    take_turn if guess.length > 1 || guess != guess[/[a-z]+/]

    # We have a valid guess. Let's check it!
    check_guess(guess)
  end

  def check_guess(guess)
    # Check to see if the letter guessed is contained in the secret word at
    # at least one time.
    if @secret_word.include?(guess)

      # Use the each_with_index to find each element in the secret guess array
      # that matches the current guess. Once a match is found use the index to
      # change the element at the same index in guess feedback array to show
      # the correct location.
      @secret_word.each_with_index { |character, index| @guess_feedback[index] = guess if character == guess }

    else
      # If not a correct guess add the guess to the array of previous guesses.
      # Increment the count of incorrect guesses.
      @previous_guesses.push(guess)
      @incorrect_guesses += 1
    end
  end

  def check_for_win_or_lose
    # Check for loss. If they lost display the interface one last time showing
    # the completed hangman then exit with a 'You Lose!' message.
    lose_game if @incorrect_guesses >= 8

    # Check for win. If they won, display the interface one last time showing
    # the completed word and exit with a 'You Win!' message.
    win_game if @secret_word == @guess_feedback
  end

  def lose_game
    display_game
    puts "You Lose! The word was #{@secret_word.join}."
    exit
  end

  def win_game
    display_game
    puts "You Win!"
    exit
  end
end

# Implement the ability to save the game at the start of the player's turn.


# Display the main menu for the game.
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

    # Start take the first turn.
    game.take_turn
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
