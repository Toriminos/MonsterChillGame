extends Control
class_name PlayerUiManager

@export var dialogue_manager : DialogueManager
@export var interactable_text: Label

func change_interactable_text(new_text : String) :
	interactable_text.text = new_text

func start_dialogue(dialogue_data : Dictionary) :
	dialogue_manager.start_dialogue(dialogue_data)
