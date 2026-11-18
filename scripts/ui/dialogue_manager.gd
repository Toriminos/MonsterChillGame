extends MarginContainer

class_name DialogueManager

@export var dialogue_text: RichTextLabel
@export var dialogue_cooldown: Timer


var _dialogue_data : Dictionary = {}
var _current_dialogue : Dictionary = {}
var _in_dialogue : bool = false

func _process(delta: float) -> void:
	if _in_dialogue and dialogue_cooldown.is_stopped() and Input.is_action_just_pressed("player_interaction"):
		if(_current_dialogue != null) :
			show_dialogue(_current_dialogue["next"])
		else :
			print("Dialogue interactable : _current_dialogue is null")

func start_dialogue(dialogue_data) -> void:
	_dialogue_data = dialogue_data
	if _dialogue_data != {}:
		GameManager.toggle_player_mouvement(false)
		self.visible = true
		_in_dialogue = true
		GameManager.toggle_player_interaction(false)
		show_dialogue("start")
	else :
		print("Dialogue interactable : Couldn't find the dialogue file")
	
func exit_dialogue() :
	GameManager.toggle_player_mouvement(true)
	self.visible = false
	_in_dialogue = false
	GameManager.toggle_player_interaction(true)
	dialogue_text.text = ""
	_dialogue_data = {}
	_current_dialogue = {}
	
func load_dialogue_via_id(dialogue_id : String, dialogue_data : Dictionary) -> bool :
	if dialogue_id in dialogue_data :
		_current_dialogue = dialogue_data[dialogue_id]
		return true
	return false

func _set_flags(flags_to_set : Dictionary) -> void :
	for flg in flags_to_set.keys() :
		if(GameState.get_flag(flg) != null):
			GameState.set_flag(flg, flags_to_set.get(flg))
			print("Dialogue interactable : flag change -> {0} set to {1}".format([flg, GameState.get_flag(flg)]))
		else:
			print("Dialogue interactable : Warning -> try to set flag {0}, but it doesn't exist".format([flg]))

func show_dialogue(id : String) :
	var correct_id : bool = load_dialogue_via_id(id, _dialogue_data)
	if(correct_id) :
		dialogue_cooldown.start()
		dialogue_text.text = _current_dialogue.get("localization_id","missing_text")
		if(_current_dialogue.has("flags")):
			var flags_to_set : Dictionary =  _current_dialogue.get("flags")
			_set_flags(flags_to_set)
	else :
		exit_dialogue()
