require './lib/node'
require './lib/binary_search_tree.rb'
require "minitest/autorun"
require "minitest/pride"
require 'pry'

class BinarySearchTreeTest < Minitest::Test

  def test_initialize_with_root_node_nil
    tree = BinarySearchTree.new
    refute tree.root_node
  end

  def test_it_inserts_one_node
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")

    assert_equal Node, tree.root_node.class
    assert_equal "Bill & Ted's Excellent Adventure", tree.root_node.title
  end

  def test_it_inserts_one_node_and_knows_its_title
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal "Bill & Ted's Excellent Adventure", tree.root_node.title
  end

  def test_it_inserts_one_node_and_knows_its_score
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 61, tree.root_node.score
  end

  def test_it_inserts_a_node_to_the_left_of_root
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    assert_equal 16, tree.left_child.root_node.score
  end

  def test_it_inserts_a_node_to_the_right_of_root
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(92, "Sharknado 3")
    assert_equal 92, tree.right_child.root_node.score
  end

  def test_it_knows_it_includes_a_score
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert tree.include?(61)
  end

  def test_it_knows_it_includes_a_score_with_more_than_one_movie
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(41, "The Revenant")
    assert tree.include?(41)
  end

  def test_it_knows_when_it_does_not_include_a_score
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "The Departed")
    tree.insert(41, "The Revenant")

    refute tree.include?(22)
  end

  def test_it_find_depth_when_it_is_zero
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 0, tree.depth_of(61)
  end

  def test_it_finds_depth_when_it_is_one
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "The Departed")
    tree.insert(41, "The Revenant")

    assert_equal 1, tree.depth_of(16)
  end

  def test_it_finds_depth_when_it_is_two
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "The Departed")
    tree.insert(41, "The Revenant")
    assert_equal 2, tree.depth_of(50)
  end

  def test_it_finds_depth_when_it_is_three
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "The Departed")
    tree.insert(41, "The Revenant")
    assert_equal 3, tree.depth_of(41)
  end
  
  def test_it_finds_max_of_one
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal({"Bill & Ted's Excellent Adventure" => 61}, tree.max)
  end
  
  def test_it_findsmax_of_many_movies
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "The Departed")
    tree.insert(41, "The Revenant")
    tree.insert(99, "Alien vs. Predator")
    tree.insert(97, "Meru")
    tree.insert(0, "Nacho Libre")

    assert_equal({"Alien vs. Predator" => 99}, tree.max)
  end

  def test_it_finds_min_of_one
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal({"Bill & Ted's Excellent Adventure" => 61}, tree.min)
  end
  
  def test_it_finds_min_of_many_movies
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "The Departed")
    tree.insert(41, "The Revenant")
    tree.insert(99, "Alien vs. Predator")
    tree.insert(97, "Meru")
    tree.insert(0, "Nacho Libre")

    assert_equal({"Nacho Libre" => 0}, tree.min)
  end

  def test_sort_one_movies_by_score_into_an_array
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal([{"Bill & Ted's Excellent Adventure"=>61}], tree.sort)
  end
  
  def test_sort_multiple_movies_by_score_into_an_array
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    assert_equal([{"Johnny English"=>16},{"Hannibal Buress: Animal Furnace"=>50},{"Bill & Ted's Excellent Adventure"=>61},{"Sharknado 3"=>92}], tree.sort)
  end


  def test_it_counts_node_when_there_is_one
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 1, tree.node_count
  end

  def test_it_counts_node_when_there_are_multiple
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "The Departed")
    tree.insert(41, "The Revenant")
    tree.insert(99, "Alien vs. Predator")
    tree.insert(97, "Meru")
    tree.insert(0, "Nacho Libre")

    assert_equal 8, tree.node_count
  end

 def test_it_returns_health_with_one_movie_at_depth_0
    tree = BinarySearchTree.new
    tree.insert(98, "Animals United")
    assert_equal([[98, 1, 100]], tree.health(0))

 end
 
 def test_it_returns_health_with_multiple_movies_at_depth_0
    tree = BinarySearchTree.new
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

    assert_equal([[98, 7, 100]], tree.health(0))
  end

  def test_it_returns_health_with_multiple_movies_at_depth_1
    tree = BinarySearchTree.new
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

    assert_equal([[58, 6, 85]], tree.health(1))
  end

  def test_it_returns_health_with_multiple_movies_at_depth_2
    tree = BinarySearchTree.new
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

    assert_equal([[36, 2, 28], [93, 3, 42]], tree.health(2))
  end

  def test_it_loads_a_file
    tree = BinarySearchTree.new
    assert tree.load('./lib/movies.txt')
  end

  def test_it_loads_a_file_and_returns_number_of_movies_loaded
    tree = BinarySearchTree.new
    assert_equal 99, tree.load('./lib/movies.txt')
  end

  def test_it_counts_leaves_with_one_node
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 1, tree.leaves
  end

  def test_it_counts_leaves_with_multiple_movies
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "The Departed")
    tree.insert(41, "The Revenant")
    tree.insert(99, "Alien vs. Predator")
    tree.insert(97, "Meru")
    tree.insert(0, "Nacho Libre")

    assert_equal 3, tree.leaves
  end

  def test_it_finds_height_with_one_movie
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 1, tree.height
  end

  def test_it_finds_height_with_many_movies
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "The Departed")
    tree.insert(41, "The Revenant")
    tree.insert(99, "Alien vs. Predator")
    tree.insert(97, "Meru")
    tree.insert(0, "Nacho Libre")
    tree.insert(30, "The Imitation Game")

    assert_equal 5, tree.height
  end

  def test_it_can_insert_a_tree_with_one_node_and_adds_number_of_nodes
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "The Departed")

    new_tree = BinarySearchTree.new
    new_tree.insert(41, "The Revenant")

    tree.insert_tree(new_tree)
    assert_equal 5, tree.node_count
  end

  def test_it_can_insert_a_tree_with_one_node_and_includes_added_score
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "The Departed")

    new_tree = BinarySearchTree.new
    new_tree.insert(41, "The Revenant")

    tree.insert_tree(new_tree)
    assert tree.include?(41)
  end

  def test_it_can_insert_a_tree_with_multiple_nodes_and_adds_node_counts
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "The Departed")

    new_tree = BinarySearchTree.new
    new_tree.insert(41, "The Revenant")
    new_tree.insert(99, "Alien vs. Predator")
    new_tree.insert(97, "Meru")
    new_tree.insert(0, "Nacho Libre")

    tree.insert_tree(new_tree)

    assert_equal 8 , tree.node_count
  end

  def test_it_deletes_the_root_node_when_there_is_one_movie
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.delete(61)

    refute tree.include?(61)
  end

  def test_it_deletes_a_child_when_there_are_two_nodes
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.delete(16)

    refute tree.include?(16)
  end

  def test_it_deletes_a_child_when_there_are_two_nodes_but_keeps_root
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.delete(16)

    refute tree.include?(16)
    assert tree.include?(61)
  end

  def test_it_deletes_a_root_node_when_there_are_two_nodes_but_keeps_child

    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.delete(61)

    assert tree.include?(16)
    refute tree.include?(61)
  end

  def test_it_deletes_a_node_and_reinserts_its_child_when_there_are_three_nodes
    tree = BinarySearchTree.new
    tree.insert(41, "The Revenant")
    tree.insert(99, "Alien vs. Predator")
    tree.insert(97, "Meru")

    tree.delete(97)

    assert tree.include?(99)
    refute tree.include?(97)
  end

  def test_it_deletes_a_node_and_reinserts_all_its_children
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "The Departed")
    tree.insert(41, "The Revenant")
    tree.insert(99, "Alien vs. Predator")
    tree.insert(97, "Meru")
    tree.insert(0, "Nacho Libre")

    tree.delete(16)

    refute tree.include?(16)
    assert tree.include?(50)
    assert tree.include?(41)
    assert tree.include?(0)
    assert tree.include?(97)
  end


end