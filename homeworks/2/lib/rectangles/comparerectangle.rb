require_relative "./rectangle.rb"

#Trida porovnava dva ctverce a navrati zda se protinaji ci ne
class CompareRect
  # funkce porovna zda predane ctverce rect1 a rect2 se nekde protinaji za pomoci leve spodni souradnice a delky hrany
  def compare(rect1,rect2)
    r1x,r1y = rect1.leftdown
    r2x,r2y = rect2.leftdown
    
    rozsah_x1 = Range.new(r1x,r1x + rect1.l)
    rozsah_y1 = Range.new(r1y,r1y + rect1.l)
    
    rozsah_x2 = Range.new(r2x,r2x + rect1.l)
    rozsah_y2 = Range.new(r2y,r2y + rect1.l)
    
    return true if (rozsah_x1.include?(r2x)) and (rozsah_y1.include?(r2y))
    return true if (rozsah_x2.include?(r1x)) and (r1y rozsah_y2.include?(r1y))
    # nespada do rozsahu 
    return false
  end
  
  # funkce vypocte sjednoceni, resp. obsah sjednoceni
  def obsah(rect1, rect2)
    r1x,r1y = rect1.leftdown
    r2x,r2y = rect2.leftdown
    
    r1x2,r1y2 = rect1.rightup
    r2x2,r2y2 = rect2.rightup
    
    x1 = [r1x,r2x].max
    x2 = [r1x2, r2x2].min
    y1 = [r1y,r2y].max
    y2 = [r1y2,r2y2].min
    p [r1x,r1y,r1x2,r1y2]
    p [r2x,r2y,r2x2,r2y2]
    spolecny_obsah = (x2-x1)*(y2-y1)
    obsah_cvercu = rect1.l * rect1.l + rect2.l * rect2.l
    return obsah_cvercu - spolecny_obsah
  end
end