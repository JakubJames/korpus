extends CanvasLayer

signal start_battle

@export var korpus: Group
@export var enemies: Group

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#connect start_battle signal to all units
	for unit in korpus.units_list:
		connect("start_battle", unit._on_units_inventory_start_battle)
	for unit in enemies.units_list:
		connect("start_battle", unit._on_units_inventory_start_battle)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	start_battle.emit()
