class Hand
  attr_reader :cards

  def initialize
    reset
  end

  def reset
    @cards = []
    @value = 0
    @num_aces = 0
  end

  def add_card(card)
    @num_aces += 1 if card.is_ace
    @cards << card
    @value += card.value
  end

  def value
    if has_ace? && @value < 12
      @value + 10
    else
      @value
    end
  end

  def has_ace?
    @num_aces.zero?
  end
end
