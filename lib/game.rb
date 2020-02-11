require_relative 'card'
require_relative 'deck'
require_relative 'hand'
require_relative 'user'
require_relative 'dealer'

class Game
  attr_accessor :deck, :bids, :dealer, :user

  def initialize
    @deck = Deck.new
    @bids = 0
  end

  def start_play
    @dealer = Dealer.new
    # puts 'Введите своё имя'
    # name = gets.chomp
    @user = User.new('Ilja')
    prepare_motion
  end

  def prepare_motion
    2.times { dealer.hand.add_card(deck.pop) }
    2.times { user.hand.add_card(deck.pop) }
    bids_up
  end

  def bids_up
    if user.has_cash? && dealer.has_cash?
      user.cash - 10
      dealer.cash - 10
      bids = 20
      binding.pry
    elsif user.has_cash?
      puts "Вы победили"
    else
      puts "Казино выйграло"
    end
  end
end
