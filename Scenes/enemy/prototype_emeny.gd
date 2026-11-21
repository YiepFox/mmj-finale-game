extends CharacterBody2D
class_name Enemy

@export_group("Life")
@export var _max_life: float = 5.0

@export_group("Ground")
@export var _ground_push_force: float = 300.0
@export var _ground_hop_force: float = -120.0
@export var _ground_knockback_duration: float = 0.18
@export var _ground_knockback_friction: float = 1200.0

@export_group("Water")
@export var _water_push_force: float = 170.0
@export var _water_hop_force: float = -55.0
@export var _water_knockback_duration: float = 0.28
@export var _water_gravity: float = 220.0
@export var _max_water_fall_speed: float = 130.0
## The higher the value, the heavier the water resistance feels.
@export var _water_drag: float = 9.0

@export var _is_in_water: bool = true

var _current_life: float
var _knockback_timer: float = 0.0

func _ready() -> void:
	_current_life = _max_life

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		_is_in_water = !_is_in_water
	
	if _knockback_timer > 0.0:
		_knockback_timer -= delta

	if _is_in_water:
		_apply_water_physics(delta)
	else:
		_apply_ground_physics(delta)

	move_and_slide()

func _apply_ground_physics(_delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * _delta

	if _knockback_timer > 0.0 or is_on_floor():
		velocity.x = move_toward(velocity.x, 0.0, _ground_knockback_friction * _delta)

func _apply_water_physics(delta: float) -> void:
	# Limited gravity in water
	velocity.y += _water_gravity * delta
	velocity.y = min(velocity.y, _max_water_fall_speed)

	# Water resistance on both axes (gradually slows down momentum and upward/downward movement)
	var drag_factor: float = clamp(_water_drag * delta, 0.0, 1.0)
	velocity.x = lerp(velocity.x, 0.0, drag_factor)
	if _knockback_timer > 0.0 and velocity.y < 0.0:
		velocity.y = lerp(velocity.y, 0.0, drag_factor * 0.85)


func _take_damage(_damage: float, _from_position: Vector2) -> void:
	_current_life -= _damage
	if _current_life <= 0:
		_die()
		return

	var dir_x: float = sign(global_position.x - _from_position.x)
	if dir_x == 0.0:
		dir_x = 1.0

	if _is_in_water:
		velocity.x = dir_x * _water_push_force
		velocity.y = _water_hop_force
		_knockback_timer = _water_knockback_duration
	else:
		velocity.x = dir_x * _ground_push_force
		velocity.y = _ground_hop_force
		_knockback_timer = _ground_knockback_duration

	_play_hit_flash()

func _play_hit_flash() -> void:
	var tween := create_tween()
	tween.tween_property(self, "modulate", Color8(255, 80, 64), 0.1).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "modulate", Color.WHITE, 0.25).set_trans(Tween.TRANS_QUAD)

func _die() -> void:
	queue_free()
