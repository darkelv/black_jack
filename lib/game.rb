require_relative 'card'
require_relative 'deck'
require_relative 'hand'
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
    puts 'Введите своё имя'
    name = gets.chomp
    @user = User.new(name)
    prepare_motion
  end

  def prepare_motion
    blank_line
    dealer.reset_hand
    user.reset_hand
    @bids = 0
    2.times { dealer.hand.add_card(deck.pop) }
    dealer.close_hand
    2.times { user.hand.add_card(deck.pop) }
    show_money
    bids_up
  end

  def bids_up
    if user.has_cash? && dealer.has_cash?
      user.cash = user.cash - 10
      dealer.cash = dealer.cash - 10
      @bids = 20
      puts "Банк раунда #{bids}$"
      user_choice
    elsif user.has_cash?
      puts "Вы победили"
    else
      puts "Казино выйграло"
    end
  end

  def user_choice
    return round_result if user.hand.cards.count == 3 && dealer.hand.cards.count == 3

    show_cards
    choice_list("Пропустить ход", "Добавить карту", "Открыть карты" )
    input = gets.chomp
    loop do
      case input
        when "1"
          dealer_decision
        when "2"
          return dealer_decision if user.hand.cards.count == 3

          user.hand.add_card(deck.pop)
          user_choice
        when "3"
          round_result
      end
    end
  end

  def dealer_decision
    if dealer.hand.value < 17 && dealer.hand.cards.count < 3
      dealer.hand.add_card(deck.pop)
      dealer.close_hand
      user_choice
    else
      round_result
    end
  end

  def round_result
    blank_line
    dealer.open_hand
    show_cards
    if dealer.hand.value > user.hand.value && dealer.hand.value <= BLACK_JACK
      dealer.cash = dealer.cash + @bids
      puts "Ставка #{@bids}$ уходит в казино!"
    elsif dealer.hand.value == user.hand.value && user.hand.value <= BLACK_JACK
      puts "Очки равные, все остались при своих!"
      bid = @bids / 2
      dealer.cash = dealer.cash + bid
      user.cash = user.cash + bid
    elsif user.hand.value <= BLACK_JACK
      user.cash = user.cash + @bids
      puts "Вы выйграли #{@bids}$"
    else
      @bids = 0
      "Ставка сгорела)"
    end
    end_round_menu
  end

  def show_money
    puts "Ваш баланс #{user.cash}$"
  end

  def show_cards
    puts "Ваши карты"
    user.hand.show_cards
    puts "Карты диллера"
    dealer.hand.show_cards
  end

  def blank_line
    puts " "
  end

  def end_round_menu
    choice_list("Продолжить игру", "Завершить игру")
    input = gets.chomp
    loop do
      case input
        when "1"
          prepare_motion
        when "2"
          exit
      end
    end
  end

  def choice_list(*options)
    puts 'Введите:'
    options.each.with_index(1) do |option, index|
      puts "#{index} - #{option}"
    end
  end
end
