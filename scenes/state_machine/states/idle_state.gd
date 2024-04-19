extends State

@export var move_component: MoveComponent
@export var animated_player: AnimationPlayer

@export_group("Next States")
@export var walk_state: State
@export var interact_state: State


func _enter() -> void:
	animated_player.play("idle_" +  move_component.direction_string_v + "_" + move_component.direction_string_h)
	if _is_move_button_pressed():
		transition_to(walk_state)


func _input_process(event: InputEvent) -> void:
	if _is_move_button_pressed():
		transition_to(walk_state)
	if event.is_action_pressed("interact"):
		transition_to(interact_state)


func _is_move_button_pressed() -> bool:
	var right_strength: float = Input.get_action_strength("move_right")
	var left_strength: float = Input.get_action_strength("move_left")
	var down_strength: float = Input.get_action_strength("move_down")
	var up_strength: float = Input.get_action_strength("move_up")
	return right_strength != 0||\
	   left_strength != 0||\
	   down_strength != 0||\
	   up_strength != 0
