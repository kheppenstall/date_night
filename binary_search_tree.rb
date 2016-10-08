require './node'
require 'pry'

class BinarySearchTree

attr_reader :root_node,
            :left_child,
            :right_child
  
  def initialize
    @root_node = nil
    @left_child = nil
    @right_child = nil
  end
  
  def insert(score, title)

    if @root_node == nil
      @root_node = Node.new(score, title)
    
    elsif score >= @root_node.score
      if @right_child == nil
        @right_child = BinarySearchTree.new
      end
      @right_child.insert(score, title)

    elsif score < @root_node.score
      if @left_child == nil
        @left_child = BinarySearchTree.new
      end
      @left_child.insert(score, title)
    end
  end

  def include?(score)
    if score == @root_node.score
      return true
    elsif score > @root_node.score
      return false if @right_child == nil
      @right_child.include?(score)
    elsif score < @root_node.score
      return false if @left_child == nil
      @left_child.include?(score)
    end
  end
  
  def depth_of(score)
    depth = 0
    if score == @root_node.score
      return depth
    elsif score > @root_node.score
      depth += (1 + @right_child.depth_of(score))
    elsif score < @root_node.score
      depth += (1 + @left_child.depth_of(score))
    end
  end
  
  def max
    if @right_child == nil
      return @root_node.movie
    else
      return @right_child.max
    end
  end

  def min
    if @left_child == nil
      return @root_node.movie
    else
      return @left_child.min
    end
  end

  def sort
    sorted_movies = []
    sorted_movies << root_node.movie

    if @left_child != nil 
      sorted_movies.unshift(@left_child.sort)
    end

    if @right_child != nil 
      sorted_movies << @right_child.sort
    end
    
    return sorted_movies.flatten
  end

  def load()
  end

  def health
  end


end