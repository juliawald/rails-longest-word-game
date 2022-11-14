require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def check_word(word)
    # check if input word is on the english dictionary
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = URI.open(url).read
    my_word = JSON.parse(word_serialized)

    my_word['found']
  end

  def score
    # chech if input letters are on the list given and on the right quantity
    @letters = params[:letters].split
    attempt_array = params[:attempt].upcase.chars
    @attempt_result = ''
    attempt_array.each do |letter|
      if check_word(params[:attempt]) == false
        @attempt_result = "Sorry but '#{params[:attempt]}' is not in the english dictionary"
      elsif attempt_array.count(letter) > @letters.count(letter) || @letters.include?(letter) == false
        @attempt_result = "Sorry but '#{params[:attempt]}' can't be built from '#{@letters.join(', ')}'"
      else
        @attempt_result = 'Congrats, your word is correct!'
      end
    end
  end
end
