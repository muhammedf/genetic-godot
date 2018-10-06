
const reproduction = preload("reproduction.gd")

class Gene:
	var allele 
	
	func _init(genrep):
		var val = randf()
		allele = val
	
	func str():
		return str(allele)

class Chromosome:
	var genes
	var fitness = 0
	
	func _init(chrosize, genrep):
		genes = []
		for i in range(chrosize):
			var gene = Gene.new(genrep)
			genes.append(gene)

	func str():
		var string = "["
		for g in genes:
			string += g.str() + ", "
		string += "]"
		return string
		
	func toAlleleArray():
		var array = []
		for gene in genes:
			array.append(gene.allele)
		return array

class Population:
	
	var generation = 1
	
	var chromosomes = []
	
	var currentChromosomeIndex = -1
	
	var selector = reproduction.Selector.new()
	var crosser = reproduction.Crosser.new()
	var mutater = reproduction.Mutater.new()
	
	func _init(popsize, chrosize, genrep):
		for i in range(popsize):
			var chromosome = Chromosome.new(chrosize, genrep)
			chromosomes.append(chromosome)
	
	func select():
		return selector.select(chromosomes)
	
	func cross(c1, c2):
		crosser.cross(c1, c2)
	
	func mutate(c):
		mutater.mutate(c)
		
	func get_next():
		currentChromosomeIndex += 1
		if currentChromosomeIndex == chromosomes.size():
			return null
		return chromosomes[currentChromosomeIndex]
		
	func evolve():
		print(self.str())
		var offSprings = select()
		cross(offSprings[0], offSprings[1])
		mutate(offSprings[0])
		mutate(offSprings[1])
		generation += 1
		currentChromosomeIndex = -1
	
	func str():
		var string = ""
		for c in chromosomes:
			string += c.str() + "\n"
		return string
