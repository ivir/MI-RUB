# Trida popisuje samotny ctverec
class RectangleM
    attr_reader :x,:y,:l
  def initialize(x=0,y=0,l=0)
    @x,@y,@l = [x,y,l]
  end
  
  def leftdown
    #navraci souradnice leveho spodniho rohu
    [@x - @l/2,@y - @l/2]
  end
  
  def rightdown
    #navraci souradnice praveho spodniho rohu
    [@x + @l/2,@y - @l/2]
  end
  
  def leftup
    #navraci souradnice leveho horniho rohu
    [@x - @l/2,@y + @l/2]
  end
  
  def rightup
    #navraci souradnice praveho horniho rohu
    [@x + @l/2,@y + @l/2]
  end
end
  

