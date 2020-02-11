class Hand
  def initialize
    reset
  end

  def reset
    @cards = []
    @value = 0
    @num_aces = 0
  end
end
