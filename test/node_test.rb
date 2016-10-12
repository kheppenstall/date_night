require './lib/node'
require "minitest/autorun"
require "minitest/pride"

class NodeTest < Minitest::Test

  def test_it_knows_its_score
    node = Node.new(61, "Bill & Ted's Excellent Adventure")
    assert_equal 61, node.score
  end

  def test_it_knows_a_different_score
    node = Node.new(88, "Rocky")
    assert_equal 88, node.score
  end

  def test_it_knows_its_title
    node = Node.new(61, "Bill & Ted's Excellent Adventure")
    assert_equal "Bill & Ted's Excellent Adventure", node.title
  end

  def test_it_knows_a_different_title
    node = Node.new(88, "Rocky")
    assert_equal "Rocky", node.title
  end

  def test_title_and_score_gives_title_and_score_in_hash
    node = Node.new(61, "Bill & Ted's Excellent Adventure")
    assert_equal({"Bill & Ted's Excellent Adventure"=>61}, node.title_and_score)
  end
  
end