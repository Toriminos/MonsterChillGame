extends Node

var save_path : String = "res://save/"
var save_file_name : String = "save_1.json"

func _ready() -> void:
	new_game()

func new_game() -> void :
	GameState.reset()

func load_game() -> void :
	var save_string_path : String = save_path+save_file_name
	var save_path : String = FileAccess.get_file_as_string(save_string_path)
	var data_temp = JSON.parse_string(save_path)
	if(data_temp != null) :
		GameState.load_dictionary(data_temp)
		print(data_temp)
	

func save_game() -> void :
	DirAccess.make_dir_absolute(save_path+save_file_name)
	var file : FileAccess = FileAccess.open(save_path+save_file_name, FileAccess.WRITE)
	file.store_string(JSON.stringify(GameState.to_dictionary(), "\t"))
	file.close()

func save_file_exist() -> bool :
	return FileAccess.file_exists(save_path+save_file_name)
