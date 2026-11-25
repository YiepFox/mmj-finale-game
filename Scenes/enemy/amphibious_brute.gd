extends Enemy
class_name AmphibiousBrute


func _init() -> void:
	_max_life = 14.0
	_damage = 2.5
	_cooldown_duration = 0.35

	_ground_speed = 220.0
	_ground_jump_force = -380.0
	_ground_acceleration = 0.15

	_water_speed = 320.0
	_swiming_impulse = -240.0
	_water_jump_force = -310.0
	_water_aquatic_acceleration = 0.09
	_water_gravity = 160.0
	_max_water_fall_speed = 110.0
	_water_drag = 5.0
	_is_in_water = true


func get_infection_data() -> Dictionary:
	var data := super.get_infection_data()
	data["creature_type"] = "amphibious_brute"
	return data
