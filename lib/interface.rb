require_relative 'game'

module Interface
  module_function

  def ask_player_name
    puts 'Введите своё имя'
    gets.chomp
  end

  def show_money(user_cash)
    blank_line
    puts "Ваш баланс #{user_cash}$"
  end

  def show_bids(bids)
    blank_line
    puts "Банк раунда #{bids}$"
  end

  def show_end_game
    puts 'Игра завершилась'
  end

  def show_cards(user, dealer, dealer_hand = false)
    blank_line
    puts "Ваши карты"
    user.hand.show_cards
    puts "Cумма очков #{user.hand.value}"
    puts "Карты диллера"
    dealer.hand.show_cards
    puts "Cумма очков диллера #{dealer.hand.value}" if dealer_hand
  end

  def ask_player_decision
    blank_line
    puts 'Введите 1 если вы хотите взять еще одну карту'
    puts 'Введите 0 или любой текст чтобы передать ход дилеру'
    gets.chomp.to_i
  end

  def show_round_result(result)
    blank_line
    case result
      when :player_wins
        puts "Вы выйграли 20$"
      when :draw
        puts "Очки равные, все остались при своих!"
      when :dealer_wins
        puts "Ставка 20$ уходит в казино!"
    end
  end

  def end_round_question
    puts 'Введите 1 если вы хотите сыграть еще одну раздачу'
    puts 'Введите 0 или любой текст чтобы закончить игру'
    gets.chomp.to_i
  end

  def blank_line
    puts " "
  end
end
