class User
  attr_accessor :name, :cards, :cash

  def initialize name, cards, cash = 100
    @name = name
    @cash = cash
    @cards = cards
  end

  def one_more_card(card)
    @cards << card
  end
end
