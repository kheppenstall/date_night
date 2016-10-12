class Node

  attr_reader :score,
              :title

  def initialize(score, title)
    @score = score
    @title = title
  end

  def title_and_score
    {@title => @score}
  end

end
