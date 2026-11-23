extends CharacterBody2D

@export_category("Settings")
@export var _max_life: float = 5.0

@export_group("Ground")
<<<<<<< Updated upstream
##The parasite’s movement on the ground
@export var _ground_speed:float = 300.0
##The force of the jump on land
@export var _ground_jump_force:float = -300.0
##The acceleration and decceleration on the ground
@export var _ground_acceleration = 0.2

@export_group("Water")
##The parasite’s movement in the water
@export var _water_speed:float = 200.0
##The parasite’s propulsion within water
@export var _swiming_impulse = -180.0
##The gravity underwater
@export var _water_gravity = 250.0
##The maximum speed at which the parasite can sink underwater
@export var _max_water_fall_speed = 150.0
##The acceleration and decceleration in the water
@export var _aquatic_acceleration = 0.05
##The force of the jump in water when he touch the bottom of the water
@export var _water_jump_force = -250.0

##Check if the player is on dry land
var _is_in_ground:bool = false

=======
## The parasite’s movement on the ground
@export var _ground_speed: float = 300.0
## The force of the jump on land
@export var _ground_jump_force: float = -300.0
## The acceleration and decceleration on the ground
@export var _ground_acceleration: float = 0.2
@export var _ground_push_force: float = 250.0
@export var _ground_hop_force: float = -120.0
@export var _ground_knockback_duration: float = 0.18
@export var _ground_knockback_friction: float = 1200.0

@export_group("Water")
## The parasite’s movement in the water
@export var _water_speed: float = 200.0
## The parasite’s propulsion within water
@export var _swiming_impulse: float = -180.0
## The gravity underwater
@export var _water_gravity: float = 250.0
## The maximum speed at which the parasite can sink underwater
@export var _max_water_fall_speed: float = 150.0
## The acceleration and decceleration in the water
@export var _aquatic_acceleration: float = 0.05
## The force of the jump in water when he touch the bottom of the water
@export var _water_jump_force: float = -250.0
@export var _water_push_force: float = 170.0
@export var _water_hop_force: float = -55.0
@export var _water_knockback_duration: float = 0.28
## The higher the value, the heavier the water resistance feels.
@export var _water_drag: float = 9.0

@export_group("Attack")
## The amount of damage the parasite can inflict
@export var _damage: float = 1.0
## The default duration of the cooldown
@export var _cooldown_duration: float = 0.2

## Check if the player is on dry land
var _is_in_ground: bool = false
## The current enemy that is on the attack_area
var _current_enemy: Enemy = null
## The cooldown of the attack
var _attack_cooldown: float = 0.0
## True if he can attack
var _can_attack: bool = true
var _current_health: float = 0.0
var _is_infected: bool = false
var _base_stats: Dictionary = {}


func _ready() -> void:
	_current_health = _max_life
	_save_base_stats()

>>>>>>> Stashed changes

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if _current_enemy and not _is_infected:
			infect_enemy(_current_enemy)
		elif _is_infected:
			eject_host()
		else:
			_is_in_ground = not _is_in_ground

	if _is_in_ground:
		_terrestrial_movement(delta)
	else:
		_aquatic_movement(delta)
<<<<<<< Updated upstream
	
=======

	if _current_enemy and Input.is_action_just_pressed("attack") and _can_attack:
		_attack()

	if not _can_attack:
		_attack_cooldown -= delta
		if _attack_cooldown <= 0.0:
			_attack_cooldown = 0.0
			_can_attack = true

>>>>>>> Stashed changes
	move_and_slide()


func _save_base_stats() -> void:
	_base_stats = {
		"max_life": _max_life,
		"damage": _damage,
		"cooldown_duration": _cooldown_duration,
		"ground_speed": _ground_speed,
		"ground_jump_force": _ground_jump_force,
		"ground_acceleration": _ground_acceleration,
		"ground_push_force": _ground_push_force,
		"ground_hop_force": _ground_hop_force,
		"ground_knockback_duration": _ground_knockback_duration,
		"ground_knockback_friction": _ground_knockback_friction,
		"water_speed": _water_speed,
		"swiming_impulse": _swiming_impulse,
		"water_gravity": _water_gravity,
		"max_water_fall_speed": _max_water_fall_speed,
		"aquatic_acceleration": _aquatic_acceleration,
		"water_jump_force": _water_jump_force,
		"water_push_force": _water_push_force,
		"water_hop_force": _water_hop_force,
		"water_knockback_duration": _water_knockback_duration,
		"water_drag": _water_drag,
	}


func _apply_stats_from_dictionary(data: Dictionary) -> void:
	var new_max_life: float = data.get("max_life", _max_life)
	_calculates_infected_current_life(new_max_life)
	_max_life = new_max_life

	_damage = data.get("damage", _damage)
	_cooldown_duration = data.get("cooldown_duration", _cooldown_duration)

	_ground_speed = data.get("ground_speed", _ground_speed)
	_ground_jump_force = data.get("ground_jump_force", _ground_jump_force)
	_ground_acceleration = data.get("ground_acceleration", _ground_acceleration)
	_ground_push_force = data.get("ground_push_force", _ground_push_force)
	_ground_hop_force = data.get("ground_hop_force", _ground_hop_force)
	_ground_knockback_duration = data.get("ground_knockback_duration", _ground_knockback_duration)
	_ground_knockback_friction = data.get("ground_knockback_friction", _ground_knockback_friction)

	_water_speed = data.get("water_speed", _water_speed)
	_swiming_impulse = data.get("swiming_impulse", _swiming_impulse)
	_water_gravity = data.get("water_gravity", _water_gravity)
	_max_water_fall_speed = data.get("max_water_fall_speed", _max_water_fall_speed)
	_aquatic_acceleration = data.get("aquatic_acceleration", _aquatic_acceleration)
	_water_jump_force = data.get("water_jump_force", _water_jump_force)
	_water_push_force = data.get("water_push_force", _water_push_force)
	_water_hop_force = data.get("water_hop_force", _water_hop_force)
	_water_knockback_duration = data.get("water_knockback_duration", _water_knockback_duration)
	_water_drag = data.get("water_drag", _water_drag)

	if data.has("is_in_water"):
		_is_in_ground = not data["is_in_water"]


func infect_enemy(enemy: Enemy) -> void:
	if enemy == null or not enemy.has_method("get_infection_data"):
		return

	_apply_stats_from_dictionary(enemy.get_infection_data())
	_is_infected = true
	enemy.queue_free()
	_current_enemy = null


func eject_host() -> void:
	if not _is_infected:
		return

	_apply_stats_from_dictionary(_base_stats)
	_is_infected = false


## Function of the parasite's movement outside of water
func _terrestrial_movement(_delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * _delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = _ground_jump_force
<<<<<<< Updated upstream
	
	var direction := Input.get_axis("move_left","move_right")
	velocity.x = lerp(velocity.x, direction * _ground_speed, _ground_acceleration * _delta * 60)
=======
>>>>>>> Stashed changes

	var direction := Input.get_axis("move_left", "move_right")
	_update_attack_area_facing(direction)
	velocity.x = lerp(velocity.x, direction * _ground_speed, _ground_acceleration * _delta * 60.0)


## Function of the parasite's movement within water
func _aquatic_movement(_delta: float) -> void:
	velocity.y += _water_gravity * _delta
	velocity.y = min(velocity.y, _max_water_fall_speed)
<<<<<<< Updated upstream
	
	if Input.is_action_just_pressed("jump"):
		
		velocity.y = _water_jump_force if is_on_floor() else _swiming_impulse
	
	var direction := Input.get_axis("move_left","move_right")
	velocity.x = lerp(velocity.x, direction * _water_speed, _aquatic_acceleration * _delta * 60)
		
		
=======

	if Input.is_action_just_pressed("jump"):
		velocity.y = _water_jump_force if is_on_floor() else _swiming_impulse

	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = lerp(velocity.x, direction * _water_speed, _aquatic_acceleration * _delta * 60.0)
	_update_attack_area_facing(direction)


func _update_attack_area_facing(direction: float) -> void:
	if direction > 0.0:
		$"attack area".rotation_degrees = 0.0
	elif direction < 0.0:
		$"attack area".rotation_degrees = 180.0


func _attack() -> void:
	_can_attack = false
	_attack_cooldown = _cooldown_duration
	if _current_enemy and _current_enemy.has_method("_take_damage"):
		_current_enemy._take_damage(_damage, global_position)


func _on_attack_area_body_entered(body: Node2D) -> void:
	if body is Enemy:
		_current_enemy = body


func _on_attack_area_body_exited(body: Node2D) -> void:
	if body == _current_enemy:
		_current_enemy = null


func _calculates_infected_current_life(infected_max: float) -> void:
	if _max_life <= 0.0:
		_current_health = infected_max
		return
	var health_ratio: float = clamp(_current_health / _max_life, 0.0, 1.0)
	_current_health = health_ratio * infected_max
>>>>>>> Stashed changes
