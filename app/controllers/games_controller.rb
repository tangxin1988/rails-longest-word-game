require 'json'
require 'open-uri'
# xxx
class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.sample(10)
    @start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    # session[:start_time] = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    @letters_join = @letters.join(" ")
  end

  def score
    @end = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    @start = params[:start_time]
    @time = (@end - @start.to_f).round(2)
    # @time = (@end - session[:start_time]).round(2)
    @word = params[:word]
    @letters = params[:letters_array]
    @word_array = @word.split('')

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    result_serialized = URI.open(url).read
    @result = JSON.parse(result_serialized)['found']
  end
end
