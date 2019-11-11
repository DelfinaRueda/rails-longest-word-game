require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    9.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    random = params['letters'].split
    word = params['word']
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read) #creates a hash
    letters = word.upcase.chars
    check = letters.all? { |letter| letters.count(letter) <= random.count(letter) }
    if check == false
      @result = "sorry but #{word} can´t be built out of #{random.join(", ")}"
    elsif json['found'] == false
      @result = "Sorry but #{word} does not seem to be a valid English word..."
    else
      score = 100 * word.length
      @result = "Congratulations! #{word} is a valid English word!
      Your score is #{score}"
    end
  end
end
