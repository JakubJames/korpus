extends Node2D
class_name Group

enum GroupType {KORPUS, ENEMIES}

@export var group_type: GroupType

var units_list: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	units_list = get_children()


func kill_and_remove(killed: Unit):
	#kills and removes unit from group
	units_list.erase(killed)
