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
    dealer.reset_hand
    user.reset_hand
    binding.pry
    2.times { dealer.hand.add_card(deck.pop) }
    dealer.close_hand
    2.times { user.hand.add_card(deck.pop) }
    bids_up
  end

  def bids_up
    if user.has_cash? && dealer.has_cash?
      user.cash = user.cash - 10
      dealer.cash = dealer.cash - 10
      bids = 20
      user_choice
    elsif user.has_cash?
      puts "Вы победили"
    else
      puts "Казино выйграло"
    end
  end

  def user_choice
    show_cards
    choice_list("Пропустить ход", "Добавить карту", "Открыть карты", true)
    binding.pry

  end

  def show_cards
    puts "Ваши карты"
    user.hand.show_cards
    puts "Карты диллера"
    dealer.hand.show_cards
  end

  def choice_list(*options, extra_lines)
    puts 'Введите:'
    options.each.with_index(1) do |option, index|
      puts "#{index} - #{option}"
    end
    return unless extra_lines
    puts 'выход - для выхода из приложения'
    print '> '
  end



end
