extends InteractableBase

@export var item_to_add : ItemData
@export var quantity : int = 1

func interact() -> void :
	GameManager.player.inventory.add_item(item_to_add, quantity)
	
func can_interact() -> bool:
	return true
