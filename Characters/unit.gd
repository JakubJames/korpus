extends CharacterBody2D
class_name Unit


@export var target_group: Group
@export var hp: int = 20
	
var own_group: Group

func _ready() -> void:
	own_group = get_parent()


func _physics_process(_delta: float) -> void:
	move_and_slide()
	

func get_hit(damage: int):
	hp -= damage
	if hp <= 0:
		own_group.kill_and_remove(self)
		queue_free()


# it pass clicking start battle button to the korpus and enemies units
func _on_units_inventory_start_battle() -> void:
	$StateMachine/UnitFreeze.is_freezed = false
