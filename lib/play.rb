require_relative 'card'
require_relative 'deck'
require_relative 'hand'
require_relative 'user'
require_relative 'dealer'

class Play
  def initialize
    @deck = Deck.new
    @bids = 0
  end

  def start_play
    dealer = Dealer.new("")
    puts "Введите своё имя"
    name = gets.chomp
    user = User.new(name)
  end
end
