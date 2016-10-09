require 'pry'

class Node

  attr_reader :score,
              :title,
              :movie

  def initialize(score, title)
    @score = score
    @title = title
    @movie = {title => score}
  end

end
