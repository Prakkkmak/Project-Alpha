extends State

@export var move_component: MoveComponent
@export var animated_player: AnimationPlayer

@export_group("Next States")
@export var walk_state: State
@export var interact_state: State

func _enter() -> void:
	print("run idle")
	print("idle_" +  move_component.direction_string_v + "_" + move_component.direction_string_h)
	animated_player.play("idle_" +  move_component.direction_string_v + "_" + move_component.direction_string_h)

	
func _input_process(event: InputEvent) -> void:
	if event.is_action_pressed("move_left")||\
	   event.is_action_pressed("move_right")||\
	   event.is_action_pressed("move_up")||\
	   event.is_action_pressed("move_down"):
		transition_to(walk_state)
	if event.is_action_pressed("interact"):
		transition_to(interact_state)
