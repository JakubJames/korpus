extends CanvasLayer

signal start_battle

@export var korpus: Group
@export var enemies: Group

var hold_unit: Unit

func _process(delta: float) -> void:
	if hold_unit:	
		hold_unit.global_position = get_viewport().get_camera_2d().get_global_mouse_position()

func _on_button_pressed() -> void:
	# connect start_battle signal to all units
	for unit in korpus.units_list:
		print(unit.name)
		connect("start_battle", unit._on_units_inventory_start_battle)
	for unit in enemies.units_list:
		connect("start_battle", unit._on_units_inventory_start_battle)
	
	start_battle.emit()
	$UnitsInventoryContainer.hide()
	$Button.text = 'STOP BATTLE'


func _on_simple_unit_button_pressed() -> void:
	hold_unit = preload("res://Characters/unit.tscn").instantiate()
	korpus.add_child(hold_unit)
	hold_unit.get_node("CollisionShape2D").disabled = true
	hold_unit.target_group = enemies


func _on_archery_unit_button_pressed() -> void:
	print("archery placeholder")


func _on_big_unit_button_pressed() -> void:
	print("big placeholder")
