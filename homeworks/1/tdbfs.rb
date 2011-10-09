NEW = 0
FRESH = 1
OPEN = 2

class Node
  attr_accessor :id
  attr_reader :nodes
  attr_accessor :status
    
  def initialize(id)
    @id = id.to_i
    @nodes = Array.new
    @status = FRESH
  end
  
  def connection(node)
    @nodes << node #vlozi do pole referenci
    # jeste je nutne seradit. Jinak DFS hazi jiny vysledek
    # @nodes.sort! {|x,y| y.id.to_i <=> x.id.to_i}
  end
  
  def remove(node)
    @nodes.delete_if {|x| x == node}
  end
  
end

class Graph

  def initialize()
    @nodes = Array.new
  end
  
  def node_add(node)
    # pridani uzlu
    @nodes.push(node)
  end
  def node_del(node)
    # odstraneni uzlu
    @nodes.delete_if {|x| x == node}
  end
  
  def reset()
    @nodes.each do |nod|
      nod.status = FRESH
    end
    nil # nic nevracime
  end
  
  def link_add(nodeA,nodeB)
    # pridani propojeni
    nodA = nil
    nodB = nil
    #p "Pridavam hranu #{nodeA}-#{nodeB}."
    #p @nodes
    @nodes.each do |nod|
      # predpoklad neorientovaneho grafu -> obousmerne propojeni
      #p "Nod #{nod.id}"
      if( nod.id.to_i == nodeA.to_i )
	nodA = nod
	#p "nodA nalezen."
      elsif ( nod.id.to_i == nodeB.to_i )
	nodB = nod
	#p "nodB nalezen."
      end
      
    end
    # pokud existuji A i B, pokracujeme
    return if (nodA.nil? or nodB.nil?)
    # tak je propojime
    #p "Pridavam hranu mezi #{nodA.id} a #{nodB.id}." 
    nodA.connection(nodB)
    #nodB.connection(nodA) # nepridavame, protoze ve vstupnich datech jsou orientovane hrany
  end
  
  def bfs(start)
    #p "BFS #{start}"
    # prohledavani do sirky
    start_nod = 0
    stop_nod = 0
    
    self.reset()
    
    @nodes.each do |nod|
      if nod.id == start.to_i
	start_nod = nod
      end
    end
    
    #p @nodes
    
    return nil if start_nod.nil?
    # mame zacatek a konec
    pole = Array.new
    pole.push(start_nod)
    
    cesta = Array.new
    
    begin
      # vyjmeme a ulozime do cesty
      expanzor = pole.shift
      expanzor.status = OPEN
      #p "BFS expanzor #{expanzor.id}"
      # provedeme expanzi
      expanzor.nodes.each do |nod|
	#print "#{nod.id} "
	if (nod.status == FRESH)
	  nod.status = OPEN
	  pole.push(nod)
	end
      end
      #print "\n"
      #gets
      
      cesta.push(expanzor.id)
    end while !pole.empty?
    
    return cesta
  end

  def dfs(start)
    #p "DFS #{start}"
    # prohledavani do hloubky
    start_nod = 0
    stop_nod = 0
    
    self.reset()
    
    @nodes.each do |nod|
      if nod.id == start.to_i
	start_nod = nod
      end
    end
    
    #p @nodes
    
    return nil if start_nod.nil?
    # mame zacatek a konec
    pole = Array.new
    pole.push(start_nod)
    
    cesta = Array.new
    pole2 = Array.new
    
    begin
      # vyjmeme a ulozime do cesty
      expanzor = pole.pop
      expanzor.status = OPEN
      #p "DFS expanzor #{expanzor.id}"
      # provedeme expanzi
 
      expanzor.nodes.each do |nod|
	#print "#{nod.id} "
	if (nod.status == FRESH)
	  nod.status = OPEN
	  pole2.push(nod)
	end
      end
      
      #nize uvedene serazeni je kvuli vysledku, aby byl podobny zadani
      pole2.sort! {|x,y| y.id.to_i <=> x.id.to_i}
      pole.concat(pole2)
      pole2.clear
      # -----------
      
      #pole.each { |z| print "#{z.id} " }
      
      #print "\n"
      #gets
      
      cesta.push(expanzor.id)
    end while !pole.empty?
    
    return cesta
  end
end

class Tdbfs
  attr_reader :graphs
  
  def initialize()
    @graphs = Graph.new
  end
  
  def loadfile(file_exc)
    radky = Array.new
    File.open(file_exc,"r"){ |f|
	radky = f.readlines
    }
    pocet_grafu = (radky.shift).to_i
    #p "Pocet grafu: #{pocet_grafu}."

    if(pocet_grafu > 100)
      p "Prilis mnoho zadanych grafu, maximum je 100."
      return
    end
    
    
    pocet_grafu.times do |graf|
      # definujeme novy graf -> proto new
      @graphs = Graph.new
      # nacteme pocet_bodu
      pocet_bodu = (radky.shift).to_i
      #p "Pocet bodu: #{pocet_bodu}."
      
      if (pocet_bodu < 1) and (pocet_bodu > 1000)
	p "Pocet uzlu muzi byt v rozmezi 1...1000. Preskakuji"
	next
      end
      
      pocet_bodu.times do |bod|
	# pridame bod do grafu
	@graphs.node_add(Node.new(bod+1))
	#musime body nejdrive vytvorit, abychom k nim mohli pote pridavat hrany.
      end
      pocet_bodu.times do |bod|
	# nacteme konkretni bod a jejich spojovniky
	#p "Bod #{bod+1}"
	radek = radky.shift
	data = radek.split(/(\d*)\s?/)
	data.delete_if {|x| x==""} # promazani prazdnych poli
	#p data
	pro = data.shift.to_i
	pocet = (data.shift).to_i
	#p "Pocet spoju #{pocet}."
	pocet.times do
	  #nacteme souradnice
	  kam = (data.shift).to_i
	  #p "#{kam} "
	  @graphs.link_add(pro,kam)
	end
      end
      #p "Jde se na dotazy"
      # dotazy
      print "graph #{graf+1}\n"
      
      dotazu = 0 # limit dotazu na pocet uzlu
      
      begin
	radek = radky.shift
	# z radky musime vypreparovat odkud -> kam a pustit na to DFS + BFS
	data = radek.split(/(\d*) (\d*)/)
	data.delete_if {|x| x==""} # promazani prazdnych poli
	#p data
	odkud = data.shift.to_i
	metoda = data.shift.to_i
	#p "Odkud #{odkud} a #{metoda}"
	
	if ( (odkud<0) and (odkud > pocet_bodu))
	  p "Mimo rozsah: 1<=#{odkud}<=#{pocet_bodu}"
	  next
	end
	
	break if( (odkud==0)) # koncime
	cesta = @graphs.bfs(odkud) if (metoda == 1)
	cesta = @graphs.dfs(odkud) if (metoda == 0)
	
	# piseme
	cesta.each {|x| print x, " " }
	print "\n"
	# posun
	dotazu = dotazu.next #inkrementace o 1
      end while !( (odkud==0) and (metoda==0) ) or !(dotazu > pocet_bodu)
      p "Prilis mnoho dotazu." if (dotazu > pocet_bodu)
      
    end
  end
end

uloha = Tdbfs.new

uloha.loadfile("zadani.txt")