extends Resource
class_name item_limitation

@export var item : item_data
@export var limited_to : int

func can_carry(currentNb : int, wantToGet : int) -> bool :
    return currentNb+wantToGet <= limited_to