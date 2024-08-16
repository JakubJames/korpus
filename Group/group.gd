extends Node2D
class_name Group

var units_list: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	units_list = get_children()


func kill_and_remove(killed: Unit):
	units_list.erase(killed)
