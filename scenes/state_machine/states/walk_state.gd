extends State

@export var move_component: MoveComponent
@export var animated_player: AnimationPlayer
@export var velocity_treshold: float = 0.2

@export_group("Next States")
@export var idle_state: State
@export var interact_state: State

var process_input: bool = false

func _enter() -> void:
	animated_player.play("walk_" + move_component.direction_string_v + "_" + move_component.direction_string_h)


func _exit() -> void:
	move_component.set_direction(Vector2.ZERO)


func _update(_delta: float) -> void:
	var input_vector: Vector2 = _get_input_vector()
	move_component.set_direction(input_vector)
	animated_player.play("walk_" + move_component.direction_string_v + "_" + move_component.direction_string_h)


func set_process_input_enabled(new_process_input: bool) -> void:
	process_input = new_process_input


func _get_input_vector() -> Vector2:
	var right_strength: float = Input.get_action_strength("move_right")
	var left_strength: float = Input.get_action_strength("move_left")
	var down_strength: float = Input.get_action_strength("move_down")
	var up_strength: float = Input.get_action_strength("move_up")
	var x_movement : float = right_strength - left_strength
	var y_movement : float = down_strength - up_strength
	if right_strength + left_strength + down_strength + up_strength == 0:
		transition_to.call_deferred(idle_state)
	return Vector2(x_movement, y_movement).normalized()

func _input_process(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		transition_to(interact_state)
