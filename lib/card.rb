class Card
  attr_reader :value, :is_ace
  attr_accessor :is_hole_card

  def initialize facevalue, suit
    @face = "#{facevalue}#{suit}"
    @is_hole_card = false
    @is_ace = false

    case facevalue
      when 2..10
        @value = facevalue
      when "В"
        @value = 10
      when "Д"
        @value = 10
      when "К"
        @value = 10
      when "Т"
        @value = 1
        @is_ace = true
    end
  end

  def to_s
    if @is_hole_card
      "*"
    else
      @face
    end
  end
end
