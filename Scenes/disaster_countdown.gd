extends Timer

@export var korpus: Group
@export var enemies: Group

var burning: bool = false
var burning_interval_is_ready: bool = true
var suspense_done: bool = false
var dialogues: DialogueResource = load("res://Dialogue/main.dialogue")

func _process(_delta: float) -> void:
	if burning and burning_interval_is_ready:
		burning_interval_is_ready = false
		$BurningInterval.start()
		@warning_ignore("integer_division")
		for unit in korpus.units_list:
			unit.get_hit(10)
			
	if burning and korpus.units_list.is_empty() and !suspense_done:
		suspense_done = true
		if korpus.units_list.size() >= 10:
			DialogueManager.show_dialogue_balloon(dialogues, "after_bad")
		else:
			DialogueManager.show_dialogue_balloon(dialogues, "after_good")
		$Suspense.start()

func _on_timeout() -> void:
	burning = true
	for unit in korpus.units_list:
		unit.fire_up()
	for enemy in enemies.units_list:
		enemy.fire_up()
	$"../InGameUI".visible = false
	$DisasterAmbient.play()


func _on_burning_interval_timeout() -> void:
	burning_interval_is_ready = true


func _on_suspense_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/levelboss.tscn")
