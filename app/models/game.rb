require 'pry'
class Game

attr_reader :player, :executioner
attr_accessor :bad_guesses, :gallows, :status, :letters_guessed



  def initialize (player, executioner)
    # Have the Executioner generate the secret word
    @player = player
    @executioner = executioner
    @executioner.game = self
    @status = "new"
    self.bad_guesses = 0
    @letters_guessed = []
    # Display the hangman and blanks
    # Blanks is a hash of the positions of each letter and what letters have been revealed
    # Get the player's first guess

  end

  def start
    self.status = "playing"
    self.gallows = Gallows.new
    self.executioner.generate_secret_word
    # blanks_display = ((" _ ") * self.executioner.secret_word.answer.size).split
    # puts "Here is your word, #{self.player.name}: #{blanks_display.join(" ")}"
  end




  def check_game_status

    self.end_game(self.player) if self.executioner.secret_word.revealed
    self.end_game(self.executioner) if self.bad_guesses == 9

  end

  def get_player_guess
    # get player input of a letter (or Quit command) (or a word guesss)
    return nil if self.status == "ended"
    puts "\nIncorrect letters guessed:  #{letters_guessed.join(' ')}\n" if !letters_guessed.empty?
    puts "\nEnter your guess (letter or word), or 'quit' to quit: "
    guess = gets.chomp.upcase

  end


  def end_game(winner)
    self.status = "ended"
    case winner
    when self.player
      player_win
    when self.executioner
      executioner_win
    when "quit"
      puts "Bye!  Have a great day!"
    end
  end

  def player_win
    puts "Congratulations #{self.player.name}, you won!"
    self.player.games_won += 1
    self.executioner.games_lost += 1
    ask_to_play_again
  end

  def executioner_win
    puts "YOU LOSE! Better luck next time."
    self.executioner.games_won += 1
    self.player.games_lost += 1
    ask_to_play_again
  end

  def ask_to_play_again

    puts "Your wins: #{self.player.games_won}"
    puts "Do you want to play again? (y/n): "
    response = gets.chomp.downcase
    if response == 'y'
      new_game = Game.new(self.player, self.executioner)
      game_engine = PlayGame.new(new_game)
      game_engine.play
    else
    end_game("quit")
    end
  end

end
