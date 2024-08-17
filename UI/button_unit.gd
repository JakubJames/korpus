extends Button
class_name ButtonUnit

enum UnitTypes {SIMPLE, ARCHER, BIG}

@export var number_of_units: int
@export var unit_type: UnitTypes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RichTextLabel.text = "[color=red]" + str(number_of_units) + "[/color]"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
