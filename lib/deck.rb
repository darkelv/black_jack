require_relative 'card'

class Deck
  attr_accessor :cards

  SUITS = ["♠", "♥", "♣", "♦"]
  FACES = [2, 3, 4, 5, 6, 7, 8, 9, 10, "В", "Д", "К", "Т"]

  def initialize
    @cards = create_deck.shuffle!(random: Random.new(1))
  end

  def create_deck
    SUITS.map { |suit| FACES.map { |face| Card.new(face, suit) } }.flatten
  end

  def pop
    reset if cards.empty?
    @cards.pop
  end
end
