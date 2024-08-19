extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalVars.first_dialogue_used = true
	GlobalVars.second_dialogue_used = true


func _on_win_lose_ui_battle_ended() -> void:
	CozyMusic.play()
	$GodSounds.stop()
	for fire in $FireEffects.get_children():
		fire.visible = false
