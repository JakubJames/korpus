extends Button
class_name ButtonUnit


@export var number_of_units: int
@export var unit_type: Unit.UnitTypes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RichTextLabel.text = "[color=red]" + str(number_of_units) + "[/color]"

func decrease_number_of_units() -> void:
	number_of_units = number_of_units - 1
	$RichTextLabel.text = "[color=red]" + str(number_of_units) + "[/color]"
	
func enough_quantity() -> bool:
	return number_of_units > 0
