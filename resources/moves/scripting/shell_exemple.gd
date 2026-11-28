class_name ShellExample
extends CreatureMove

@export var _heal_amount:float = 1.5

func _execute(_user:Node2D, _context: Dictionary = {}) -> void:
	print("Heal")
