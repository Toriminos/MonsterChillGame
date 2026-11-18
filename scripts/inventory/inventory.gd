extends Node
class_name Inventory

@export var limitations : Array[ItemLimitation]
@export var inventory_array : Array[StackInformation]

func _ready() -> void:
	if(inventory_array == null) :
		inventory_array = []

func add_item(item : ItemData, nbToAdd : int = 1) -> bool :
	var inventory_id  = inventory_array.find_custom(func(stk_inf) : return stk_inf.item == item)
	var limitation_id = limitations.find_custom(func(limit) : return limit.item == item)

	if(inventory_id != -1): #the item is already in the inventory
		var stack_info = inventory_array.get(inventory_id)
		if(limitation_id != -1): #the item has a limitation
			if(limitations.get(limitation_id).can_carry(stack_info.current_quantity, nbToAdd)): #can be added
				stack_info.current_quantity += nbToAdd
				return true
			else: #can not be added
				return false
		else: #the item has no limitation
			stack_info.current_quantity += nbToAdd
			return true
	else : #the item isn't in the inventory
		if(limitation_id != -1): #the item has a limitation
			if(limitations.get(limitation_id).can_carry(0, nbToAdd)): #can be added
				inventory_array.append(StackInformation.new(item,nbToAdd))
				return true
			else: #can not be added
				return false
		else: #the item has no limitation
			inventory_array.append(StackInformation.new(item,nbToAdd))
			return true
	
func remove_item(item : ItemData) -> void :
	inventory_array.erase(item)

func has_item(item : ItemData) -> bool:
	return inventory_array.has(item)
	
func _to_string() -> String :
	var res : String = "Player inventory :\n"
	for stkInfo in inventory_array :
		res = res + ("-{0} quantity : {1}".format([stkInfo.item.item_name_id, stkInfo.current_quantity]))
	return res
