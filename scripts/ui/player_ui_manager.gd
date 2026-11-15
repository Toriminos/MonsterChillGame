extends Control
class_name player_ui_manager

@export var dialogue_manager : dialogue_manager
@export var interactable_text: Label

func _ready() :
	GameManager.playerUIManager = self

func change_interactable_text(new_text : String) :
	interactable_text.text = new_text

func start_dialogue(dialogue_data : Dictionary) :
	dialogue_manager.start_dialogue(dialogue_data)
