@abstract class_name interactable_base

extends StaticBody3D

@export var can_interact_text : String
@export var cannot_interact_text : String


@abstract func interact() -> void
@abstract func can_interact() -> bool

func display_interact_text() -> String :
	if can_interact() :
		return can_interact_text
	else :
		return cannot_interact_text
