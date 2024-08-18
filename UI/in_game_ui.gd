extends CanvasLayer
class_name InGameUI

signal start_battle

@export var korpus: Group
@export var enemies: Group
@export var spawn_area: Area2D

var hold_unit: Unit
var spawned_unit: Unit
var mouse_inside_spawn: bool = false
var battle_started: bool = false


func _process(_delta: float) -> void:
	if hold_unit:	
		hold_unit.global_position = get_viewport().get_camera_2d().get_global_mouse_position()
		
		if Input.is_action_just_pressed("left_click") and mouse_inside_spawn and !hold_unit.area_occupied:
			spawn_unit()
		
		if Input.is_action_just_pressed("right_click"):
			korpus.remove_child(hold_unit)
			hold_unit = null


# START BATTLE
func _on_button_pressed() -> void:
	if battle_started:
		get_tree().reload_current_scene()
	else:
		if korpus.units_list.is_empty():
			print('nie wybrano jednostek')
		else:
			if hold_unit:
				korpus.remove_child(hold_unit)
				hold_unit = null

			if korpus.units_list.size() >= 10:
				if  GlobalVars.first_dialogue_used and !GlobalVars.second_dialogue_used:
					DialogueManager.show_example_dialogue_balloon(
						load("res://Dialogue/main.dialogue"), "disaster"
					)
					GlobalVars.second_dialogue_used=true
				if !GlobalVars.first_dialogue_used:
					DialogueManager.show_example_dialogue_balloon(
						load("res://Dialogue/main.dialogue"), "warning_for_the_player"
					)
					GlobalVars.first_dialogue_used = true

			# connect start_battle signal to all units
			for unit in korpus.units_list:
				connect("start_battle", unit._on_units_inventory_start_battle)
			for enemy in enemies.units_list:
				connect("start_battle", enemy._on_units_inventory_start_battle)
		
			start_battle.emit()
			$UnitsInventoryContainer.hide()
			$Button.text = 'STOP BATTLE'
			spawn_area.visible = false
			battle_started = true


func _on_simple_unit_button_pressed() -> void:
	hold_unit = preload("res://Characters/unit.tscn").instantiate()
	korpus.add_child(hold_unit)
	hold_unit.get_node("CollisionShape2D").disabled = true
	hold_unit.unit_type = Unit.UnitTypes.SIMPLE


func _on_archery_unit_button_pressed() -> void:
	print("archery placeholder")


func _on_big_unit_button_pressed() -> void:
	hold_unit = preload("res://Characters/big_unit.tscn").instantiate()
	korpus.add_child(hold_unit)
	hold_unit.get_node("CollisionShape2D").disabled = true
	hold_unit.unit_type = Unit.UnitTypes.BIG


func _on_spawn_area_mouse_entered() -> void:
	mouse_inside_spawn = true


func _on_spawn_area_mouse_exited() -> void:
	mouse_inside_spawn = false

func spawn_unit() -> void:
	spawned_unit = null
	if hold_unit.unit_type == Unit.UnitTypes.SIMPLE:
		if $UnitsInventoryContainer/HBoxContainer/SimpleUnitButton.enough_quantity():
			spawned_unit = preload("res://Characters/unit.tscn").instantiate()
			$UnitsInventoryContainer/HBoxContainer/SimpleUnitButton.decrease_number_of_units()
	elif hold_unit.unit_type == Unit.UnitTypes.BIG:
		if $UnitsInventoryContainer/HBoxContainer/BigUnitButton.enough_quantity():
			spawned_unit = preload("res://Characters/big_unit.tscn").instantiate()
			$UnitsInventoryContainer/HBoxContainer/BigUnitButton.decrease_number_of_units()
	else:
		push_error("Wrong unit type: " + hold_unit.get_class())
		
	if spawned_unit:
		spawned_unit.target_group = enemies
		korpus.units_list.append(spawned_unit)
		korpus.add_child(spawned_unit)
		spawned_unit.global_position = get_viewport().get_camera_2d().get_global_mouse_position()


func get_current_number_of_units(unit_type: Unit.UnitTypes) -> int:
	if unit_type == Unit.UnitTypes.SIMPLE:
		return $UnitsInventoryContainer/HBoxContainer/SimpleUnitButton.number_of_units
	elif unit_type == Unit.UnitTypes.ARCHER:
		return $UnitsInventoryContainer/HBoxContainer/ArcheryUnitButton.number_of_units
	elif unit_type == Unit.UnitTypes.BIG:
		return $UnitsInventoryContainer/HBoxContainer/BigUnitButton.number_of_units
	else:
		push_error('wrong unit type')
		return -1


func hide_start_button() -> void:
	$Button.visible = false;
