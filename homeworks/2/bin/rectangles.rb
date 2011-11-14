require '../lib/rectangles/comparerectangle.rb'
ctverec_osloveni = 'prvniho'

ctverce = Array.new(0)
l,x,y = [0,0,0]
2.times do |i|
  begin
  print "Zadejte delku hrany #{ctverec_osloveni} ctverce: "
  l = gets
  l = Integer(l)

  print "Zadejte x-ovou souradnici stredu" + ctverec_osloveni + "ctverce: "
  x = gets
  x = Integer(x)
  
  print "Zadejte y-ovou souradnici stredu #{ctverec_osloveni} ctverce: "
  y = gets
  y = Integer(y)
  
  ctverce[i] = [x,y,l]
  ctverec_osloveni = 'druheho'
  rescue ArgumentError
    puts 'Spatny vstup.'
    exit
  end
end
# mame vsechny vstupy
x,y,l = ctverce[0]
ct1 = RectangleM.new x,y,l
x,y,l = ctverce[1]
ct2 = RectangleM.new x,y,l

data = CompareRect.new
if( data.compare(ct1,ct2) )
  # prochazi skrze sebe -> vypocitame obsah sjednoceni
  obsah = data.obsah(ct1,ct2)
  puts "Obsah sjednoceni dvou ctvercu je #{obsah}."
else
  puts "Ctverce se ani nedotykaji"
end