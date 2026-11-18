extends Node

var player : Player

func _ready() :
	TranslationServer.set_locale("english")

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("debug_input") and player != null):
		print(player.inventory.to_string())
	#options de debug

func start_dialogue(dialogue_data : Dictionary) :
	player.player_ui.start_dialogue(dialogue_data)

func toggle_player_interaction(status : bool) :
	player.interaction_cast.enabled = status

func toggle_player_mouvement(status : bool) :
	player.can_move = status

func check_all_condition(to_check : Array[Conditions]) -> bool :
	for condi in to_check :
		if !condi.is_valid():
			return false
	return true
