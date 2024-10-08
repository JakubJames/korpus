extends CharacterBody2D
class_name Unit

enum UnitTypes {SIMPLE, ARCHER, BIG, GOD}

@export var target_group: Group
@export var hp: int
@export var damage_factor: int
@export var move_speed: int
@export var unit_type: UnitTypes
@export var fire_effect: Sprite2D
	
var own_group: Group
var area_occupied: bool = false

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


func _on_check_occupation_body_entered(_body: Node2D) -> void:
	area_occupied = true


func _on_check_occupation_body_exited(_body: Node2D) -> void:
	area_occupied = false

func fire_up():
	if fire_effect:
		fire_effect.visible = true
