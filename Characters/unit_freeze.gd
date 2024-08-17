extends State
class_name UnitFreeze

var is_freezed = true

# Called when the node enters the scene tree for the first time.
func physics_update(_delta: float):
	#when start battle button was clicked it changes unit's state to attack
	if !is_freezed:
		Transitioned.emit(self, "UnitAttack")
