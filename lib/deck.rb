class Deck
  attr_accessor :cards

  SUITS = [♠, ♥, ♣, ♦]
  FACES = [2, 3, 4, 5, 6, 7,8, 9, 10, "В", "Д", "К", "Т"]

  def initialize
    @cards = create_deck
  end

  def create_deck
    SUITS.map { |suit| FACES.map { |face| Card.new(face, suit) } }
  end
end
