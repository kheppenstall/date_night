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

  def greater_score_than?(other_node)
    if @score > other_node.score
      return true
    else
      return false
    end
  end

end

node1 = Node.new(61, "Bill & Ted's Excellent Adventure")
node2 = Node.new(61, "Bill & Ted's Excellent Adventure")
