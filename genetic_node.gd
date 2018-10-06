extends Node

enum GenotypeRepresentation {Binary, RealValued, Integer}

export(PackedScene) var Individual
export(int) var PopulationSize = 10
export(int) var ChromosomeSize = 10
export(GenotypeRepresentation) var GenRep
export(int) var MaxParallelSim = 1

var core = preload("model/core.gd")

var population
var indDict = {}

func _ready():
	population = core.Population.new(PopulationSize, ChromosomeSize, 0)

func _process(delta):
	while indDict.size() < MaxParallelSim && population.generation == 1:
		var ind = Individual.instance()
		var chro = population.get_next()
		if chro == null:
			population.generation = 0
			break
		indDict[ind] = chro
		ind.chromosome = chro.toAlleleArray()
		add_child(ind)
		ind.connect("fitnessed", self, "_fit_this")
		
func _fit_this(fitness, ind):
	var chro = indDict[ind]
	chro.fitness = fitness
	indDict.erase(ind)
	ind.queue_free()
	if indDict.size() == 0 && population.generation == 0:
		population.evolve()
