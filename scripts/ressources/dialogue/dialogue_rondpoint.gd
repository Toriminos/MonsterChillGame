extends Resource

class_name dialogue_rondpoint

@export var priority : int
@export var branches : Array[dialogue_branch]

func get_actual_valid_branches_max_priority() -> dialogue_branch :
	var res : dialogue_branch = null
	for branche in branches :
		if GameManager.check_all_condition(branche.conditions) :
			if res == null or res.priority < branche.priority :
				res = branche
	return res
