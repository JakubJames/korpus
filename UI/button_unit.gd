extends Button
class_name ButtonUnit


@export var unit_type: Unit.UnitTypes

var number_of_units: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if unit_type == Unit.UnitTypes.SIMPLE:
		number_of_units = GlobalVars.simple_unit_num
	elif unit_type == Unit.UnitTypes.ARCHER:
		number_of_units = GlobalVars.archery_unit_num
	elif unit_type == Unit.UnitTypes.BIG:
		number_of_units = GlobalVars.big_unit_num
	
	$RichTextLabel.text = "[color=red]" + str(number_of_units) + "[/color]"

func decrease_number_of_units() -> void:
	number_of_units = number_of_units - 1
	$RichTextLabel.text = "[color=red]" + str(number_of_units) + "[/color]"
	
func enough_quantity() -> bool:
	return number_of_units > 0


func _on_in_game_ui_update_global_vars() -> void:
	if unit_type == Unit.UnitTypes.SIMPLE:
		GlobalVars.simple_unit_num = number_of_units
	elif unit_type == Unit.UnitTypes.ARCHER:
		GlobalVars.archery_unit_num = number_of_units
	elif unit_type == Unit.UnitTypes.BIG:
		GlobalVars.big_unit_num = number_of_units
