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

  def test_load

  end

  def test_health

  end

end