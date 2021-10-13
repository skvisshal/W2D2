class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses
  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, '_')
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end 

  def already_attempted?(char)
    @attempted_chars.include?(char) ? true : false
  end

  def get_matching_indices(char)
    result = []
    @secret_word.each_char.with_index do |ch, i|
      result.push(i) if ch == char
    end
    result
  end

  def fill_indices(char, array)
    array.each do |index|
      @guess_word[index] = char
    end
  end

  def try_guess(char)
    if self.already_attempted?(char)
      puts "already attempted"
      return false
    else
      @attempted_chars.push(char)
      indices = self.get_matching_indices(char)
      indices.empty? ? @remaining_incorrect_guesses -= 1 : fill_indices(char, indices)
      return true
    end
  end

  def ask_user_for_guess
    puts "Enter a char:"
    response = gets.chomp
    self.try_guess(response)
  end

  def win?
    if @guess_word.join == @secret_word
      puts "WIN"
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      return true
    else
      return false
    end
  end

  def game_over?
    if self.win? || self.lose?
      puts @secret_word
      return true
    else
      return false
    end
  end
end
