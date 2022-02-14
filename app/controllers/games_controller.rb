require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def scores
    @answer = params[:answer].upcase
    letters_to_check = params[:letters].split('')
    answer_to_check = @answer.split('')
    is_in_the_grid = true
    is_a_real_word = false
    @win = false


    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)


    answer_to_check.each do |letter|
      if !letters_to_check.include?(letter)
        is_in_the_grid = false
        break
      end
    end
    is_a_real_word = true if word['found'] == true

    if is_in_the_grid == true && is_a_real_word == true
      @win = true
    end

    @win
  end
end
