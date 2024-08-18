extends Node2D

var dialogues: DialogueResource = load("res://Dialogue/main.dialogue")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.show_dialogue_balloon(dialogues, "tutorial")
