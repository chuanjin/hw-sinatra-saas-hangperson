class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end
  
  def guess(c)
    if c.nil? or c.empty? or not c.match(/\w/ )
      raise ArgumentError
    end
    
    char = c.downcase
    return false if @guesses.include?(char) or @wrong_guesses.include?(char)
        
    if @word.include?(char)
        @guesses << char
    else
      @wrong_guesses << char
    end
  end
  
  def word_with_guesses
    @not_yet_hits = (@word.chars.uniq - @guesses.chars).reduce('', :+)
    @word.tr(@not_yet_hits, '-')
  end
  
  def check_win_or_lose
    return :win if @word.chars.uniq.length == @guesses.length
    return :lose if @wrong_guesses.length >= 7
    :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
