extends CharacterBody2D


@export_category("Settings")

@export_group("Ground")
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
##The current enemy that is on the attack_area
var _current_enemy = null

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		_is_in_ground = !_is_in_ground
	
	if _is_in_ground:
		_terrestrial_movement(delta)
	else:
		_aquatic_movement(delta)
		
	if _current_enemy and Input.is_action_just_pressed("attack"):
		_current_enemy._life -= 1
		_current_enemy._damage(position)
	
	move_and_slide()
	
##Function of the parasite's movement outside of water
func _terrestrial_movement(_delta):
	if not is_on_floor():
		velocity += get_gravity() * _delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = _ground_jump_force
	
	var direction := Input.get_axis("move_left","move_right")
	
	if direction == 1:
		$"attack area".rotation_degrees = 0
	if direction == -1:
		$"attack area".rotation_degrees = 180
	
	velocity.x = lerp(velocity.x, direction * _ground_speed, _ground_acceleration * _delta * 60)

##Function of the parasite's movement within water
func _aquatic_movement(_delta):
	velocity.y += _water_gravity * _delta
	velocity.y = min(velocity.y, _max_water_fall_speed)
	
	if Input.is_action_just_pressed("jump"):
		
		velocity.y = _water_jump_force if is_on_floor() else _swiming_impulse
	
	var direction := Input.get_axis("move_left","move_right")
	velocity.x = lerp(velocity.x, direction * _water_speed, _aquatic_acceleration * _delta * 60)
	
	if direction == 1:
		$"attack area".rotation_degrees = 0
	if direction == -1:
		$"attack area".rotation_degrees = 180
		


func _on_attack_area_body_entered(body: Node2D) -> void:
	if body is Enemy:
		_current_enemy = body


func _on_attack_area_body_exited(body: Node2D) -> void:
	if body is Enemy:
		_current_enemy = null
