extends State
class_name UnitAttack

@export var unit: Unit

var target_units_list: Array
var local_target: Unit
var attack_is_ready: bool = true
var attack_radius: int

func enter():
	if !unit.target_group.is_node_ready():
		await unit.target_group.ready
		
	target_units_list = unit.target_group.units_list
	local_target = target_units_list[randi()% target_units_list.size()]
	
	if unit.unit_type == Unit.UnitTypes.SIMPLE:
		attack_radius = 18
	elif unit.unit_type == Unit.UnitTypes.BIG:
		attack_radius = 25


func physics_update(_delta: float):
	# when no enemy left, change state to walking around (idle)
	if target_units_list.size() == 0:
		Transitioned.emit(self, "UnitIdle")
		# checks who win
		if unit.own_group.group_type == Group.GroupType.KORPUS:
			print("WIN")
		if unit.own_group.group_type == Group.GroupType.ENEMIES:
			print("LOSE")
	# when target was killed it assigned new targer
	elif !local_target:
		var target_n: int = randi()% target_units_list.size()
		local_target = target_units_list[target_n]
	else:
		var direction = local_target.global_position - unit.global_position
		
		if direction.length() > attack_radius:
			unit.velocity = direction.normalized() * unit.move_speed
		elif attack_is_ready:
			attack_is_ready = false
			$"../../AttackCooldown".start()
			unit.velocity = Vector2()
			var damage: int = randi_range(1, unit.damage_factor)
			local_target.get_hit(damage)
			#print(str(unit.name) + " gives " + str(damage) + "damage to " + str(local_target.name))


func _on_attack_cooldown_timeout() -> void:
	attack_is_ready = true
