extends Node

const GRAVITY := 2.5
const MAX_INT := 9223372036854775807 # https://docs.godotengine.org/en/stable/classes/class_int.html

#inclusive
static func is_number_in_range(n: float, start: float, end: float) -> bool:
	return n >= start and n < end
