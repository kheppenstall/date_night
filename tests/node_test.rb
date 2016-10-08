require './node'
require "minitest/autorun"
require "minitest/pride"
require 'pry'

class NodeTest < Minitest::Test

  def test_initialize
    assert node = Node.new(61, "Bill & Ted's Excellent Adventure")
  end

  def test_score
    node = Node.new(61, "Bill & Ted's Excellent Adventure")
    assert_equal 61, node.score
  end

  def test_movie_title
    node = Node.new(61, "Bill & Ted's Excellent Adventure")
    assert_equal "Bill & Ted's Excellent Adventure", node.title
  end

  def test_node_contains_movie_title_and_score_in_hash
    node = Node.new(61, "Bill & Ted's Excellent Adventure")
    assert_equal({"Bill & Ted's Excellent Adventure"=>61}, node.movie)
  end
  
  def test_greater_score_than?
    node1 = Node.new(61, "Bill & Ted's Excellent Adventure")
    node2 = Node.new(92, "Sharknado 3")
    assert_equal false, node1.greater_score_than?(node2)
    assert_equal true, node2.greater_score_than?(node1)
  end

end