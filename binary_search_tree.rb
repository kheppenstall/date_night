require './node'
require 'pry'

class BinarySearchTree

attr_reader :root_node,
            :left_child,
            :right_child,
  
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
    if @root_node == nil
      return false
    end

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

  def node_count
    counter = 0

    if @root_node != nil
      counter = 1
    end

    if @left_child != nil
      counter += @left_child.node_count
    end

    if @right_child != nil
      counter += @right_child.node_count
    end

    return counter
  end

  def recursive_health(depth)
    tree_health = []

    if depth == 0
      current_node_count = node_count
      score = @root_node.score

      sub_tree_score_and_count_and_count = [score, current_node_count, current_node_count]
      tree_health << sub_tree_score_and_count_and_count
      return tree_health
    
    else
      if @left_child != nil
        tree_health << @left_child.recursive_health(depth - 1)
      end

      if @right_child != nil
        tree_health << @right_child.recursive_health(depth - 1)
      end
    end
    return tree_health
  end

  def health(depth)
    total_node_count = node_count
    overall_health = recursive_health(depth).flatten

    overall_health.each_index do |index|
      if (index + 1) % 3 == 0
        overall_health[index] = ((overall_health[index].to_f / total_node_count.to_f) * 100).to_i
      end
    end

    overall_health = overall_health.each_slice(3).to_a
    return overall_health
  end

  def load(filename)
    lines = File.readlines(filename)
    
    lines_no_breaks = lines.map do |line|
      line.delete("\n")
    end
    
    lines_as_arrays = lines_no_breaks.map do |line|
      line.split(', ')
    end

    scores_and_titles = lines_as_arrays.map do |score_and_title|
      score = score_and_title[0].to_i
      title = score_and_title[1]
      [score, title]
    end

    counter = 0

    scores_and_titles.each do |score_and_title|
      score = score_and_title[0]
      title = score_and_title[1]
      unless include?(score)
        insert(score, title)
        counter += 1
      end
    end

    return counter
  end

  def leaves
    number_of_leaves = 0

    if @left_child != nil && @right_child != nil
      number_of_leaves += @left_child.leaves + @right_child.leaves
    elsif @left_child == nil && @right_child == nil
      number_of_leaves += 1
    elsif @right_child == nil
      number_of_leaves += @left_child.leaves
    elsif @left_child == nil
      number_of_leaves += @right_child.leaves
    end

    return number_of_leaves
  end

  def height
    height = 1
    if @right_child != nil && @left_child != nil
      
      if @right_child.height > @left_child.height
        height += @right_child.height
      else
        height += @left_child.height
      end

    elsif @right_child != nil
      height += @right_child.height

    elsif @left_child != nil
      height += @left_child.height
    end

    return height

  end

  def insert_tree(tree)
    if tree.root_node != nil
      insert(tree.root_node.score , tree.root_node.title)
    end
    
    if tree.right_child != nil
      insert_tree(tree.right_child)
    end
    
    if tree.left_child != nil
      insert_tree(tree.left_child)
    end
  end

#NOT GOING TO WORK SINCE WE CAN'T DELETE FROM THE ROOT NODE
  # def delete(score)
  
  #   if @left_child != nil
  #     if @left_child.root_node.score == score
        
  #       insert_tree(@left_child.left_child)
  #       insert_tree(@left_child.right_child)

  #       @left_child = nil

  #     else
  #       @left_child.delete(score)
  #     end
  #   end

  #   if @right_child != nil
  #    if @right_child.root_node.score == score
        
  #       insert_tree(@right_child.left_child)
  #       insert_tree(@right_child.right_child)

  #       @right_child = nil
        
  #     else
  #       @right_child.delete(score)
  #     end
  #   end
  # end

  

end

