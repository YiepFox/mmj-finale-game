extends CharacterBody2D
class_name Enemy

var _default_life = 3
var _life = _default_life

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if _life <= 0:
		queue_free()
	
	move_and_slide()

func _damage() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color8(255, 80, 64), 0.1).set_trans(Tween.TRANS_EXPO)
	await tween.finished
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self, "modulate", Color.WHITE, 0.3).set_trans(Tween.TRANS_QUAD)
