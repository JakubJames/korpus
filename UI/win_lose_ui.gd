extends CanvasLayer

@export var korpus: Group
@export var enemies: Group
@export var in_game_ui: InGameUI
@export var next_level_name: String

var already_informed = false
var simple_units_num_on_map: int
var archer_units_num_on_map: int
var big_units_num_on_map: int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# already informed is used because this chunk of code should be executed once
	if in_game_ui.battle_started and !already_informed:
		# checks who win
		if enemies.units_list.is_empty():
			# WIN
			already_informed = true
			$RichTextLabel.append_text('[center][font_size={30}]YOU WIN[/font_size][/center]')
			
			for unit_on_map in korpus.units_list:
				if unit_on_map.unit_type == Unit.UnitTypes.SIMPLE:
					simple_units_num_on_map += 1
				if unit_on_map.unit_type == Unit.UnitTypes.ARCHER:
					archer_units_num_on_map += 1
				if unit_on_map.unit_type == Unit.UnitTypes.BIG:
					big_units_num_on_map += 1
			update_global_vars()
			
			in_game_ui.hide_start_button()
			$NextLevelButton.visible = true
			visible = true
		if korpus.units_list.is_empty():
			# LOSE
			already_informed = true
			$RichTextLabel.append_text('[center][font_size={30}]YOU LOSE[/font_size][/center]')
			simple_units_num_on_map	= 0
			archer_units_num_on_map	= 0
			big_units_num_on_map	= 0
			update_global_vars()
			visible = true
			


func update_global_vars() -> void:
	print("On map left:")
	print("Simple unit: " + str(simple_units_num_on_map))
	print("Archer unit: " + str(archer_units_num_on_map))
	print("Big unit: " + str(big_units_num_on_map))
	GlobalVars.simple_unit_num 	= in_game_ui.get_current_number_of_units(Unit.UnitTypes.SIMPLE) + simple_units_num_on_map
	GlobalVars.archery_unit_num = in_game_ui.get_current_number_of_units(Unit.UnitTypes.ARCHER) + archer_units_num_on_map
	GlobalVars.big_unit_num 	= in_game_ui.get_current_number_of_units(Unit.UnitTypes.BIG) + big_units_num_on_map


func _on_next_level_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/" + next_level_name + ".tscn")
