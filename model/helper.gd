
class MyRange:
	
	var start
	var end
	
	func _init(_start, _end):
		start = _start
		end = _end

	func is_in(number):
		return number >= start && number < end
