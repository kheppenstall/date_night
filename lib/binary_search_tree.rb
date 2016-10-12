require_relative 'node'

class BinarySearchTree

  attr_reader   :root_node,
                :left_child,
                :right_child

  def root_exists?
    root_node != nil
  end

  def left_child_exists?
    left_child != nil
  end

  def right_child_exists?
    right_child != nil
  end

  def move_right?(score)
    score > root_node.score
  end

  def move_left?(score)
    score < root_node.score
  end

  def create_right_child
    @right_child = BinarySearchTree.new if !right_child_exists?
  end

  def create_left_child
    @left_child = BinarySearchTree.new if !left_child_exists?
  end

  def insert_right(score, title)
    create_right_child
    right_child.insert(score, title)
  end

  def insert_left(score, title)
    create_left_child
    left_child.insert(score, title)
  end

  def insert(score, title)
    if !(root_exists?)
      @root_node = Node.new(score, title)
    else 
      insert_right(score, title) if move_right?(score)
      insert_left(score, title) if move_left?(score)
    end
    depth_of(score)
  end
  
  def find_in_tree?(score)
    if score == root_node.score
      true
    elsif move_right?(score)
      right_child.include?(score) if right_child_exists?
    elsif move_left?(score)
      left_child.include?(score) if left_child_exists?
    end
  end

  def include?(score)
    find_in_tree?(score) if root_exists?
  end
  
  def depth_of(score)
    depth = 0
    if move_right?(score)
      depth += 1 + right_child.depth_of(score)
    elsif move_left?(score)
      depth += 1 + left_child.depth_of(score)
    end
    depth
  end
  
  def max
    if right_child_exists?
      right_child.max
    else
      root_node.title_and_score
    end
  end

  def min
    if left_child_exists?
      left_child.min
    else
      root_node.title_and_score
    end
  end
  
  def sort
    sorted_movies = []
    sorted_movies << root_node.title_and_score
     
    sorted_movies.unshift left_child.sort if left_child_exists?
    sorted_movies << right_child.sort if right_child_exists?
         
    sorted_movies.flatten
  end

  def set_node_counter
    if root_exists? 
      1
    else
      0
    end 
  end

  def node_count
    counter = set_node_counter
    counter += left_child.node_count if left_child_exists?
    counter += right_child.node_count if right_child_exists?
    counter
  end

  def one_score_and_count
    current_node_count = node_count
    score = root_node.score
    [score, current_node_count]
  end

  def scores_and_counts(depth)
    scores_and_counts = []

    scores_and_counts << one_score_and_count if depth == 0
      
    if left_child_exists?
      scores_and_counts << left_child.scores_and_counts(depth - 1)
    end

    if right_child_exists?
        scores_and_counts << right_child.scores_and_counts(depth - 1)
    end
      
    scores_and_counts.flatten
  end

  def percentage(count, total_node_count)
    ((count.to_f / total_node_count.to_f) * 100).to_i
  end

  def load_health(item, index, overall_health, total_node_count)
    if index.odd?
      count = item
      overall_health << count
  
      node_percentage = percentage(count, total_node_count)
      overall_health << node_percentage

    else
      score = item
      overall_health << score
    end
  end

  def create_health_array(scores_and_counts, total_node_count)
    overall_health = []
    scores_and_counts.each_with_index do |item, index|
      load_health(item, index, overall_health, total_node_count)
    end
    overall_health
  end

  def health(depth)
    total_node_count = node_count
    scores_and_counts = scores_and_counts(depth)
    tree_health = create_health_array(scores_and_counts, total_node_count)
    tree_health.each_slice(3).to_a
  end

  def load(filename)
    lines = File.readlines(filename)
    
    lines_no_breaks = lines.map {|line| line.delete("\n")}
    
    lines_as_arrays = lines_no_breaks.map do |line| 
      line.split(', ')
      # TRUNCATING MOVIES WITH COMMAS IN TITLE
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
    counter
  end

  def leaves
    number_of_leaves = 0

    number_of_leaves += left_leaves
    number_of_leaves += right_leaves

    if !left_child_exists? && !right_child_exists?
      number_of_leaves += 1
    end

    number_of_leaves
  end

  def left_leaves
    if left_child_exists?
      left_child.leaves
    else 0
    end
  end


  def right_leaves
    if right_child_exists?
      right_child.leaves
    else 0
    end
  end
  
  def height
    height = 1
    
    if right_child_exists? && left_child_exists?
      height += height_of_bigger_branch
    elsif right_child_exists?
      height += right_child.height
    elsif left_child_exists?
      height += left_child.height
    end
    
    height
  end

  def height_of_bigger_branch
    if right_child.height > left_child.height
      right_child.height
    else
      left_child.height
    end
  end

  def insert_tree(tree)
    if tree.root_exists?
      insert(tree.root_node.score , tree.root_node.title)
      insert_tree(tree.right_child) if tree.right_child_exists?
      insert_tree(tree.left_child) if tree.left_child_exists?
    end
  end

  def delete_node(score)
    if root_node.score == score
      @root_node = nil
      reinsert_right_tree
      reinsert_left_tree
    end
  end

  def reinsert_right_tree
    if right_child_exists?
      temp_right_child = right_child
      @right_child = nil
      insert_tree(temp_right_child)
    end
  end

  def reinsert_left_tree
    if left_child_exists?
      temp_left_child = left_child
      @left_child = nil
      insert_tree(temp_left_child)
    end
  end

  def delete(score)
    right_child.delete(score) if move_right?(score)
    left_child.delete(score)if move_left?(score)
    delete_node(score)
  end

end

