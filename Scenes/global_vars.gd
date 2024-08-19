extends Node

var simple_unit_num: int	= 20
var archery_unit_num: int	= 0
var big_unit_num: int		= 3

var first_dialogue_used: bool	= false
var second_dialogue_used: bool	= false


func reset_to_default() -> void:
	simple_unit_num		= 20
	archery_unit_num	= 0
	big_unit_num		= 3

	first_dialogue_used		= false
	second_dialogue_used 	= false
