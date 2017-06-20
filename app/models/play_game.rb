class PlayGame

  attr_reader :game

  def initialize(game)
    @game = game
  end



  def play

    self.game.start
    until game.status == "ended" do
      self.game.get_player_guess
      check_out_player_guess
      check_game_status
      # end_game if appropriate
      display_hangman_and_blanks
      # back to get_player_guess
    end

  end



end
