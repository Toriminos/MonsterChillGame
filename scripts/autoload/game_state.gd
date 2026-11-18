@tool
extends Node

var fatigue : int = 0

var flags : Dictionary = {
	"test" : true,
	"test_2" : true,
	"test_3" : true
}

var _DEFAULT : Dictionary = {
	"flags" :
		{
			"test" : true,
			"test_2" : true,
			"test_3" : true
		},
	"fatigue" : 0
}

func get_flag(key : String) -> Variant :
	return flags.get(key) 
	
func set_flag(key : String, val : Variant) :
	flags.set(key, val)

func reset() -> void :
	load_dictionary(_DEFAULT)

func load_dictionary(dict : Dictionary) -> void :
	flags = dict.get("flags", _DEFAULT.get("flags"))
	fatigue = dict.get("fatigue", _DEFAULT.get("fatigue"))

func to_dictionary() -> Dictionary :
	var res : Dictionary = {
		"flags" : flags,
		"fatigue" : fatigue
	}
	return res
