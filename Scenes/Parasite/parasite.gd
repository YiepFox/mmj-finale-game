extends CharacterBody2D


@export_category("Settings")
##The parasite’s movement on the ground
@export var _ground_speed:float = 300.0
##The force of the jump on land
@export var _ground_jump_force:float = -300.0

##The parasite’s movement in the water
@export var _water_speed:float = 180.0
##The parasite’s propulsion within water
@export var _swiming_impulse = -220.0
##The gravity underwater
@export var _water_gravity = 250.0
##The maximum speed at which the parasite can sink underwater
@export var _max_water_fall_speed = 150.0

##Check if the player is on dry land
var _is_in_ground:bool = false


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		_is_in_ground = !_is_in_ground
	
	if _is_in_ground:
		_terrestrial_movement(delta)
	else:
		_aquatic_movement(delta)
	
	move_and_slide()
	
##Function of the parasite's movement outside of water
func _terrestrial_movement(_delta):
	if not is_on_floor():
		velocity += get_gravity() * _delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = _ground_jump_force
	
	var direction := Input.get_axis("move_left","move_right")
	velocity.x = direction * _ground_speed

##Function of the parasite's movement within water
func _aquatic_movement(_delta):
	velocity.y += _water_gravity * _delta
	velocity.y = min(velocity.y, _max_water_fall_speed)
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = _swiming_impulse
	
	var direction := Input.get_axis("move_left","move_right")
	velocity.x = move_toward(velocity.x, direction * _water_speed, 15.0)
		
		
