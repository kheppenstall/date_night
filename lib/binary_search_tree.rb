require './lib/node'
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

  def root_exists?
    @root_node != nil
  end

  def left_child_exists?
    @left_child != nil
  end

  def right_child_exists?
    @right_child != nil
  end

  def insert(score, title)

    if !root_exists?
      @root_node = Node.new(score, title)
    
    elsif score >= @root_node.score
      if !right_child_exists?
        @right_child = BinarySearchTree.new
      end
      @right_child.insert(score, title)

    elsif score < @root_node.score
      if !left_child_exists?
        @left_child = BinarySearchTree.new
      end
      @left_child.insert(score, title)
    end
  end

  
  def include?(score)
    if !root_exists?
      return false
    end

    if score == @root_node.score
      return true
    elsif score > @root_node.score
      return false if !right_child_exists?
      @right_child.include?(score)
    elsif score < @root_node.score
      return false if !left_child_exists?
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
    if !right_child_exists?
      return @root_node.title_and_score
    else
      return @right_child.max
    end
  end

  def min
    if !left_child_exists?
      return @root_node.title_and_score
    else
      return @left_child.min
    end
  end

  def sort
    sorted_movies = []
    sorted_movies << root_node.title_and_score

    if left_child_exists? 
      sorted_movies.unshift(@left_child.sort)
    end

    if right_child_exists?
      sorted_movies << @right_child.sort
    end
    
    return sorted_movies.flatten
  end

  def node_count
    counter = 0

    if root_exists?
      counter = 1
    end

    if left_child_exists?
      counter += @left_child.node_count
    end

    if right_child_exists?
      counter += @right_child.node_count
    end

    return counter
  end

  def sub_tree_root_scores_and_counts(depth)
    sub_trees_root_scores_and_counts = []

    if depth == 0
      current_node_count = self.node_count
      score = @root_node.score

      sub_trees_root_scores_and_counts << [score, current_node_count]
      return sub_trees_root_scores_and_counts.flatten
    
    else
      if left_child_exists?
        sub_trees_root_scores_and_counts << @left_child.sub_tree_root_scores_and_counts(depth - 1)
      end

      if right_child_exists?
        sub_trees_root_scores_and_counts << @right_child.sub_tree_root_scores_and_counts(depth - 1)
      end
    end
    return sub_trees_root_scores_and_counts.flatten
  end

  def health(depth)
    total_node_count = node_count
    scores_and_counts = sub_tree_root_scores_and_counts(depth)

    overall_health = []

    scores_and_counts.each_with_index do |item, index|
      if index.odd?
        count = item
        overall_health << count
        
        node_percentage = ((count.to_f / total_node_count.to_f) * 100).to_i
        overall_health << node_percentage

      else
        score = item
        overall_health << score
      end
    end

    overall_health.each_slice(3).to_a
  end

  def load(filename)
    lines = File.readlines(filename)
    
    lines_no_breaks = lines.map {|line| line.delete("\n")}
    
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

    if left_child_exists? && right_child_exists?
      number_of_leaves += @left_child.leaves + @right_child.leaves

    elsif !left_child_exists? && !right_child_exists?
      number_of_leaves += 1

    elsif !right_child_exists?
      number_of_leaves += @left_child.leaves

    elsif !left_child_exists?
      number_of_leaves += @right_child.leaves
    end

    return number_of_leaves
  end

  def height
    height = 1
    if right_child_exists? && left_child_exists?
      
      if @right_child.height > @left_child.height
        height += @right_child.height
      else
        height += @left_child.height
      end

    elsif right_child_exists?
      height += @right_child.height

    elsif left_child_exists?
      height += @left_child.height
    end

    return height

  end

  def insert_tree(tree)
    if tree.root_exists?
      insert(tree.root_node.score , tree.root_node.title)
      insert_tree(tree.right_child) if tree.right_child_exists?
      insert_tree(tree.left_child) if tree.left_child_exists?
    end
  end

  def delete(score)
    if @root_node.score == score
      @root_node = nil

      if right_child_exists?
        temp_right_child = @right_child
        @right_child = nil
        insert_tree(temp_right_child)
      end
      if left_child_exists?
        temp_left_child = @left_child
        @left_child = nil
        insert_tree(temp_left_child)
      end
      
    elsif score > root_node.score
      @right_child.delete(score)

    elsif score < root_node.score
      @left_child.delete(score)
    end
  end

end

