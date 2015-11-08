class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  
  attr_accessor :word,:guesses,:wrong_guesses,:count
  
  def guess (guess)
    
    raise ArgumentError.new("throws an error when nil") if guess.nil? # 'throws an error when nil'
    raise ArgumentError.new("throws an error when empty") if guess.empty? # 'throws an error when empty'
    raise ArgumentError.new("throws an error when not a letter") if !(!!(guess =~/[a-zA-Z]+/)) # 'throws an error when not a letter'
    
    
    guess = guess.downcase
    if(word =~ /([#{guess}])/)
    	return false if (@guesses =~ /([#{guess}])/)
    	@guesses += guess
    	@count +=1
    else
    	return false if (@wrong_guesses =~ /([#{guess}])/)
    	@wrong_guesses += guess
    	@count +=1
    end
  end
  
  # display word with guessed items

  def word_with_guesses
    if (word.empty?)
      word_guesses = "-"
    else  
      word_guesses = ""
    end
    
    @word.chars do |myg| 
      if !(@guesses =~ /([#{myg}])/)
        word_guesses += "-"
      else
        word_guesses += myg
      end
    end
    word_guesses
  end

  # HangpersonGame game status should be win when all letters guessed
  # HangpersonGame game status should be lose after 7 incorrect guesses
  # HangpersonGame game status should continue play if neither win nor lose
  
  def check_win_or_lose
    if(@count >6)
      @result = :lose
    else
      @result = word_with_guesses
      if !(@result =~/[-]/)
        @status = :win
      else
        @status = :play
      end
    end
  end
  
  
  # =========
  def initialize(word)
    @count =0
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end



  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
