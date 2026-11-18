@tool
class_name DialogueBranch

extends Resource
@export var dialogues_path : String = "res://ressources/dialogues/"

@export var priority : int
@export var dialogue_file_name : String:
	set(value) :
		dialogue_file_name = value
		notify_property_list_changed()
@export var conditions : Array[Conditions]

func _validate_property(property: Dictionary) -> void:
	if property.name == "dialogue_file_name" :
		var dir : DirAccess = DirAccess.open(dialogues_path)
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(dir.get_files())

func get_dialogue_dictionnary() -> Dictionary :
	var path : String = str(dialogues_path,dialogue_file_name)
	var dg_data = JSON.new()
	return dg_data.parse_string(FileAccess.get_file_as_string(path))
