extends CharacterBody2D
class_name Enemy

##The default life at the start of the game
var _default_life = 5
##the current life
var _life = _default_life
##the force of the push when the parasite push the Enemy
var _push_force = 300

var _is_pushing:bool = false

var push_angle:float

func _physics_process(delta: float) -> void:
	
	"""if not is_on_floor():
		velocity += get_gravity() * delta"""
	
	if _life <= 0:
		queue_free()
	
	if _is_pushing and (wrap(rad_to_deg(velocity.angle()), 0, 360) <= wrap(rad_to_deg(push_angle) + 180, 0, 360) + 5
		and wrap(rad_to_deg(velocity.angle()), 0, 360) >= wrap(rad_to_deg(push_angle) + 180, 0, 360) - 5):
			
		velocity += Vector2.from_angle(push_angle) * delta * 300
		
	else:
		if _is_pushing:
			velocity = Vector2.ZERO
			_is_pushing = false
	
	move_and_slide()

func _damage(_from_position) -> void:
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color8(255, 80, 64), 0.1).set_trans(Tween.TRANS_EXPO)
	await tween.finished
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self, "modulate", Color.WHITE, 0.3).set_trans(Tween.TRANS_QUAD)
	
	_is_pushing = true
	push_angle = position.angle_to_point(_from_position)
	var vector2_angle = Vector2.from_angle(push_angle + deg_to_rad(180))
	velocity = vector2_angle * _push_force
