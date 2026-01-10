class_name FieldManager
extends TileMapLayer

const FIELD_SIZE = Vector2i(10, 10)


## Fruits positions <Vector2i, Fruit>
var registry_fruits: Dictionary = {}

## Danger positions <Vector2i, bool>
var registry_danger: Dictionary = {}

## Ded position <Vector2i, Ded>
var registry_ded: Dictionary = {}


func out_of_range(pos: Vector2i) -> bool:
	return pos.x < 0 || pos.y < 0 || pos.x >= FIELD_SIZE.x || pos.y >= FIELD_SIZE.y 
