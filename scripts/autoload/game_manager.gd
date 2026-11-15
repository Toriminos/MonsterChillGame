extends Node

@export var player : Player
@export var playerUIManager : player_ui_manager

func _ready() :
	TranslationServer.set_locale("english")

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("debug_input")):
		print("Player inventory :")
		for item in player.inventory.inventory_array :
			print("	-{0} quantity : {1}".format([item.item.item_name_id, item.current_quantity]))
	#options de debug

func start_dialogue(dialogue_data : Dictionary) :
	playerUIManager.start_dialogue(dialogue_data)

func toggle_player_interaction(status : bool) :
	player.interaction_cast.enabled = status

func check_all_condition(to_check : Array[conditions]) -> bool :
	for condi in to_check :
		if !condi.is_valid():
			return false
	return true
