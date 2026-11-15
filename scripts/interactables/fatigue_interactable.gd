extends interactable_base

@export var add_x_to_fatigue : int = 0

func interact() -> void :
	GameManager.player.change_fatigue(add_x_to_fatigue)
	
func can_interact() -> bool:
	return GameManager.player.can_do_action(add_x_to_fatigue)
