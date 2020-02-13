require_relative 'card'
require_relative 'deck'
require_relative 'hand'
require_relative 'interface'
require_relative 'user'
require_relative 'dealer'

class Game
  attr_accessor :deck, :bids, :dealer, :user

  BLACK_JACK = 21

  def initialize
    @deck = Deck.new
    @bids = 0
  end

  def start_play
    @dealer = Dealer.new
    name = Interface.ask_player_name
    @user = User.new(name)
    prepare_motion
  end

  def prepare_motion
    dealer.reset_hand
    user.reset_hand
    @bids = 0
    2.times do
      dealer.hand.add_card(deck.pop)
      user.hand.add_card(deck.pop)
    end
    dealer.close_hand
    Interface.show_money(user.cash)
    bids_up
  end

  def bids_up
    return Interface.show_end_game if user.cash.zero? && dealer.cash.zero?

    user.cash = user.cash - 10
    dealer.cash = dealer.cash - 10
    @bids = 20
    Interface.show_bids(@bids)
    user_choice
  end

  def user_choice
    return calc_result if user.hand.cards.count == 3 && dealer.hand.cards.count == 3

    Interface.show_cards(user, dealer)
    input = Interface.ask_player_decision
    loop do
      break if input != 1
      user.hand.add_card(deck.pop)
    end
    dealer_decision
  end

  def dealer_decision
    loop do
      break if dealer.hand.value >= 17 || dealer.hand.cards.count >= 3

      dealer.hand.add_card(deck.pop)
      dealer.close_hand
    end
    calc_result
  end

  def calc_result
    dealer.open_hand
    if dealer.hand.value > 21
      result = :player_wins
      user.cash = user.cash + @bids
    end

    delta = user.hand.value - dealer.hand.value
    if delta > 0
      result = :player_wins
      dealer.cash = dealer.cash + @bids
    elsif delta == 0
      result = :draw
      bid = @bids / 2
      dealer.cash = dealer.cash + bid
      user.cash = user.cash + bid
    elsif delta < 0
      result = :dealer_wins
      dealer.cash = dealer.cash + @bids
    end
    Interface.show_cards(user, dealer, true)
    Interface.show_round_result(result)

    user_ask = Interface.end_round_question
    return  prepare_motion if user_ask == 1

    exit
  end
end
