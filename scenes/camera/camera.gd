extends Camera2D

@export var target: Node2D
@export var drag_force: float = 4.0

func _process(delta: float) -> void:
	if target == null:
		return
	var target_position: Vector2 = target.position
	global_position = global_position.lerp(target_position, 1 - exp(-delta * drag_force))
