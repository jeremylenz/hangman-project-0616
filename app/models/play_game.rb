class PlayGame

  attr_reader :game

  def initialize(game)
    @game = game
  end



  def play  #  still buggy!  Needs some work

    self.game.start
    until game.status == "ended" do
      self.game.check_game_status
      # end_game if appropriate
      display_hangman_and_blanks
      # back to get_player_guess
      guess = self.game.get_player_guess
      check_out_player_guess(guess)


    end

  end

  def check_out_player_guess(guess)
    if guess.length == 1 && ('A'..'Z').to_a.include?(guess)
      check_out_letter_guess(guess)
    elsif guess.length > 1
      check_out_word_guess(guess)
    else
      puts "Please enter a valid character."
      sleep(1)
    end


  end

  def check_out_word_guess(word_guess)
    if word_guess == "QUIT"
      end_game(self.game.executioner)
    end

    if word_guess != nil
      # binding.pry
      if self.game.executioner.evaluate_word_guess(word_guess) == true
      self.game.executioner.secret_word.revealed = true
      else
        puts "Incorrect."
        sleep(1)
        self.game.bad_guesses += 1
      end

    end
  end

  def check_out_letter_guess(letter)

    if self.game.executioner.evaluate_guess(letter) == true
      puts "Correct!"
      sleep(1)
    else
      puts "Incorrect."
      sleep(1)
      self.game.bad_guesses += 1
    end

  end

  def display_hangman_and_blanks

    if self.game.status != "ended"
      self.game.gallows.draw(self.game.bad_guesses)
      self.game.executioner.secret_word.update_blanks
    end

  end

end
