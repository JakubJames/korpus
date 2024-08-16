extends State
class_name UnitIdle

@export var unit: CharacterBody2D
@export var move_speed := 10.0

var move_direction: Vector2
var wander_time: float
#var local_target: Unit

func randomize_wander():
	move_direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	wander_time = randf_range(1, 5)

func enter():
	#if $"../..".target:
		#local_target = $"../..".target
	#else:
		#push_error("target haven't set for unit follow")
	randomize_wander()
	
func update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
		
func physics_update(_delta: float):
	if unit:
		unit.velocity = move_direction * move_speed
		
	#var direction = local_target.global_position - unit.global_position
	
	#if direction.length() < 70:
		#Transitioned.emit(self, "UnitFollow")
