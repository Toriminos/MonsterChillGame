extends interactable_base

@export var dialogueRondPoint : dialogue_rondpoint

func interact() -> void:
	var dialogue_data : Dictionary = get_dialogue_data()
	if dialogue_data != null:
		GameManager.start_dialogue(dialogue_data)
	else :
		print("Dialogue interactable : Couldn't find the dialogue file")

func can_interact() -> bool:
	var branche : dialogue_branch = dialogueRondPoint.get_actual_valid_branches_max_priority()
	return branche != null

func get_dialogue_data() -> Dictionary :
	var branche : dialogue_branch = dialogueRondPoint.get_actual_valid_branches_max_priority()
	return branche.get_dialogue_dictionnary()
