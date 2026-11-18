extends Resource
class_name ItemLimitation

@export var item : ItemData
@export var limited_to : int

func can_carry(currentNb : int, wantToGet : int) -> bool :
	return currentNb+wantToGet <= limited_to
