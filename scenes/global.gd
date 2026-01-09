extends Node


const FIELD_SIZE = Vector2i(10, 10)
const MOVE_TIME = 0.25


func out_of_range(pos: Vector2i) -> bool:
	return pos.x < 0 || pos.y < 0 || pos.x >= FIELD_SIZE.x || pos.y >= FIELD_SIZE.y 
