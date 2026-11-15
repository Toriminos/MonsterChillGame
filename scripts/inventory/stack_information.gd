extends Resource
class_name stack_information

var item : item_data
var current_quantity : int 

func _init(itemToAdd : item_data, quantityToAdd : int) -> void :
    self.item = itemToAdd
    self.current_quantity = quantityToAdd