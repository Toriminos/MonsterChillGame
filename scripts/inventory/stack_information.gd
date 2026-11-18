extends Resource
class_name StackInformation

var item : ItemData
var current_quantity : int 

func _init(itemToAdd : ItemData, quantityToAdd : int) -> void :
	self.item = itemToAdd
	self.current_quantity = quantityToAdd
