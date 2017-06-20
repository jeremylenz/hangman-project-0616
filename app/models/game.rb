require 'pry'
class Game

attr_reader :player, :executioner
attr_accessor :bad_guesses, :gallows, :status



  def initialize (player, executioner)
    # Have the Executioner generate the secret word
    @player = player
    @executioner = executioner
    @status = "new"
    self.bad_guesses = 0
    # Display the hangman and blanks
    # Blanks is a hash of the positions of each letter and what letters have been revealed
    # Get the player's first guess

  end

  def start
    self.status = "playing"
    self.gallows = Gallows.new
    self.executioner.generate_secret_word
    blanks_display = ((" _ ") * self.executioner.secret_word.answer.size).split
    puts "Here is your word, #{self.player.name}: #{blanks_display.join(" ")}"
  end




  def check_game_status
    # Checks to see if all blanks are revealed: If so, the player wins;  Call end_game
    # Checks to see if the man is hung: If so, the Executioner wins;  Call end_game
    self.end_game(self.player) if self.executioner.secret_word.revealed
    self.end_game(self.executioner) if self.bad_guesses == 9

  end

  def get_player_guess
    # get player input of a letter (or Quit command) (or a word guesss)

    puts "#{self.bad_guesses} bad guesses so far."
    puts "Enter your guess (letter or word), or 'quit' to quit: "
    guess = gets.chomp.upcase

  end


  def end_game(winner)
    self.status = "ended"
    if winner == self.player
      puts "Congratulations #{self.player.name}, you won!"
      self.player.games_won += 1
      self.executioner.games_lost += 1
    end
    if winner == self.executioner
      puts "YOU LOSE! Better luck next time."
      self.executioner.games_won += 1
      self.player.games_lost += 1
    end
    puts "Your wins: #{self.player.games_won}"
    puts "Do you want to play again ('y'/'n')"
    response = gets.chomp.downcase
    if response == 'y'
      new_game = Game.new(self.player, self.executioner)
      game_engine = PlayGame.new(new_game)
      game_engine.play
    else
      puts "Bye!  Have a great day!"
    end
    # Display a message about the winner of the game
    # Update player's and executioner's games_won_lost
    # Ask the user if they want to play another game.  If so, create a new game and start it.
    # If not, Return to the main screen
  end

end
