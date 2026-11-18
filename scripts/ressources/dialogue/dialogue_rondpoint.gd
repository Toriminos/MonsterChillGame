extends Resource

class_name DialogueRondpoint

@export var priority : int
@export var branches : Array[DialogueBranch]

func get_actual_valid_branches_max_priority() -> DialogueBranch :
	var res : DialogueBranch = null
	for branche in branches :
		if GameManager.check_all_condition(branche.conditions) :
			if res == null or res.priority < branche.priority :
				res = branche
	return res
