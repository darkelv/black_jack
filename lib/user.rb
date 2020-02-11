class User
  attr_accessor :name, :cards, :cash

  def initialize name, cash = 100
    @name = name
    @cash = cash
    @cards = [Hand.new]
  end
end
