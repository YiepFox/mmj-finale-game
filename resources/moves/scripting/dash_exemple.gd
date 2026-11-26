class_name DashExample
extends CreatureMove

@export var _dash_force:float = 420.0
@export var _bonus_damage:float = 2.0

func _execute(_user:Node2D, _context: Dictionary = {}) -> void:
	var dir_x:float = _context.get("facing_x", 1.0)
	if dir_x == 0.0:
		dir_x = 1.0
	_user.velocity.x = dir_x * _dash_force
	
	var target: Enemy = _context.get("target", null)
	if target and target.has_method("_take_damage"):
		target._take_damage(_bonus_damage,_user.global_position)
		print("Dash")
