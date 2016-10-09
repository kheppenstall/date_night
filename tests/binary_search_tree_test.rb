require './node'
require './binary_search_tree.rb'
require "minitest/autorun"
require "minitest/pride"
require 'pry'

class BinarySearchTreeTest < Minitest::Test

  def test_initialize
    assert tree = BinarySearchTree.new
  end

  def test_insert_root
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    node = Node.new(61, "Bill & Ted's Excellent Adventure")

    assert_equal tree.root_node.score , node.score
    assert_equal tree.root_node.title , node.title
  end

  def test_insert_right
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")

    assert tree.insert(16, "Johnny English")
  end

  def test_insert_left
    tree = BinarySearchTree.new
    tree.insert(16, "Johnny English")

    assert tree.insert(61, "Bill & Ted's Excellent Adventure")
  end

  def test_insert_right_and_left
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")

    assert tree.insert(16, "Johnny English")
    assert tree.insert(92, "Sharknado 3")
    assert tree.insert(50, "The Departed")
    assert tree.insert(41, "The Revenant")
  end

  def test_include?
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "The Departed")
    tree.insert(41, "The Revenant")

    assert tree.include?(61)
    assert tree.include?(16)
    assert tree.include?(92)
    assert tree.include?(50)
    assert tree.include?(41)
    assert_equal false, tree.include?(2)
  end

  def test_depth_of
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "The Departed")
    tree.insert(41, "The Revenant")

    assert_equal 0, tree.depth_of(61)
    assert_equal 1, tree.depth_of(16)
    assert_equal 1, tree.depth_of(92)
    assert_equal 2, tree.depth_of(50)
    assert_equal 3, tree.depth_of(41)
  end
  
  def test_max
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

  def test_min
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

  def test_sort
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    assert_equal([{"Johnny English"=>16},{"Hannibal Buress: Animal Furnace"=>50},{"Bill & Ted's Excellent Adventure"=>61},{"Sharknado 3"=>92}], tree.sort)
  end

  def test_node_count
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
    assert_equal 4, tree.left_child.node_count
    assert_equal 3, tree.right_child.node_count
    assert_equal 2, tree.left_child.right_child.node_count
  end

  def test_health
    tree = BinarySearchTree.new
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

    assert_equal([[98, 7, 100]], tree.health(0))
    assert_equal([[58, 6, 85]], tree.health(1))
    assert_equal([[36, 2, 28], [93, 3, 42]], tree.health(2))
  end

  def test_load
    tree = BinarySearchTree.new
    assert_equal 99, tree.load('movies.txt')
  end

  def test_leaves
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

    tree = BinarySearchTree.new
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

    assert_equal 2, tree.leaves
    assert_equal 2, tree.left_child.leaves
    assert_equal 1, tree.left_child.left_child.leaves
    assert_equal 1, tree.left_child.right_child.leaves
  end

  def test_height
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
    assert_equal 3, tree.right_child.height
    assert_equal 4, tree.left_child.height
    assert_equal 1, tree.left_child.left_child.height
    assert_equal 2, tree.right_child.right_child.height
  end

  def test_insert_tree
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

    assert tree.include?(0)
    assert tree.include?(97)
    assert tree.include?(50)
    assert_equal 8 , tree.node_count
  end

  # def test_delete
  #   tree = BinarySearchTree.new
  #   tree.insert(61, "Bill & Ted's Excellent Adventure")
  #   tree.insert(16, "Johnny English")
  #   tree.insert(92, "Sharknado 3")
  #   tree.insert(50, "The Departed")
  #   tree.insert(41, "The Revenant")
  #   tree.insert(99, "Alien vs. Predator")
  #   tree.insert(97, "Meru")
  #   tree.insert(0, "Nacho Libre")

  #   tree.delete(16)

  #   assert_equal false, tree.include?(16)
  #   assert tree.include?(0)
  #   assert tree.include?(41)
  #   assert_equal 7, tree.node_count
  # end



end