class Dealer < User

  def initialize name = "Dealer"
    super
  end

  def close_hand
    hand.cards.each { |card| card.is_hole_card = true }
  end

  def open_hand
    hand.cards.each { |card| card.is_hole_card = false }
  end
end
