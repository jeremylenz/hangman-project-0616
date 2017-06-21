class SecretWord

  attr_reader :answer, :executioner
  attr_accessor :correct_guesses, :revealed

  def initialize(executioner)
    @answer = RandomWord.nouns(not_longer_than: 8).next.upcase
    self.correct_guesses = []
    @revealed = false
    @executioner = executioner
    puts @answer
    sleep(1)
  end

  def update_blanks
    new_blanks = self.answer.chars.each_with_object("") do |each_letter, letters_to_display|
      if self.correct_guesses.include?(each_letter)
        letters_to_display << "#{each_letter} "
      else
        letters_to_display << "_ "
      end
    end
    if !new_blanks.include?("_")
      @revealed = true
      puts "\n" + new_blanks
      self.executioner.game.end_game(self.executioner.game.player)
    else
      puts "\n" + new_blanks
    end
  end



end
