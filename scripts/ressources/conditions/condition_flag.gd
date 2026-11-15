@tool
class_name condition_flag

extends conditions

@export var flags : String:
	set(value) :
		flags = value
		notify_property_list_changed()

@export var equal_to : bool

func is_valid() -> bool:
		return GameState.flags.get(flags) == equal_to

func _validate_property(property: Dictionary) -> void:
	if property.name == "flags" :
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(GameState.flags.keys())
