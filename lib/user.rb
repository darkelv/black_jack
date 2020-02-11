class User
  attr_accessor :name, :hand, :cash

  def initialize name, cash = 100
    @name = name
    @cash = cash
    @hand = Hand.new
  end

  def reset_hand
    @hand = Hand.new
  end
end
