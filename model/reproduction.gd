
const helper = preload("helper.gd")
const MyRange = helper.MyRange

class Selector:
	func select(cs):
		var totalFit = 0
		var rangeDict = {}
		for c in cs:
			var preTotal = totalFit
			totalFit += c.fitness
			var m_range = MyRange.new(preTotal, totalFit)
			rangeDict[c] = m_range
		var ran = randf()
		var rand = ran * totalFit
		var complement = fmod(rand + totalFit/2, totalFit)
		var selecteds = []
		for i in rangeDict:
			if rangeDict[i].is_in(rand) || rangeDict[i].is_in(complement):
				selecteds.append(i)
			if(selecteds.size() == 2):
				break
		return selecteds
		
class Crosser:
	func cross(c1, c2):
		var crossGeneCount = 3
		var startIndex = randi() % (c1.genes.size() - crossGeneCount - 1)
		var c1Cross 
		for i in range(startIndex, startIndex+3):
			c1Cross= c1.genes[i].allele
			c1.genes[i].allele = c2.genes[i].allele
			c2.genes[i].allele = c1Cross
			

class Mutater:
	func mutate(c):
		var mutateGeneCount = 5
		var startIndex = randi() % (c.genes.size() - mutateGeneCount - 1)
		var inversed = []
		for i in range(startIndex, startIndex + mutateGeneCount):
			inversed.push_front(c.genes[i].allele)
		for i in range(mutateGeneCount):
			c.genes[startIndex + i].allele = inversed[i]
		