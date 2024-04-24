class_name RunState extends State

@export var move_component: MoveComponent
@export var animated_player: AnimationPlayer
@export var velocity_treshold: float = 0.2
@export var run_time: float = 1

@export_group("Next States")
@export var idle_state: State
@export var walk_state: State

@onready var timer: Timer = $Timer

var process_input: bool = false
var exhausted: bool = false

func _enter() -> void:
	move_component._max_speed *= 2
	animated_player.play("walk_" + move_component.direction_string_v + "_" + move_component.direction_string_h)
	timer.start(run_time)
	timer.timeout.connect(_on_timeout, ConnectFlags.CONNECT_ONE_SHOT)


func _exit() -> void:
	move_component._max_speed /= 2
	move_component.set_direction(Vector2.ZERO)
	timer.stop()


func _update(_delta: float) -> void:
	if exhausted:
		move_component.set_direction(Vector2.ZERO) 
		animated_player.play("idle_" + move_component.direction_string_v + "_" + move_component.direction_string_h)
		return
	var input_vector: Vector2 = _get_input_vector()
	move_component.set_direction(input_vector)
	animated_player.play("walk_" + move_component.direction_string_v + "_" + move_component.direction_string_h)

func _input_process(event: InputEvent) -> void:
	if exhausted:
		return
	if event.is_action_released("run"):
		transition_to(walk_state)

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



func _on_timeout() -> void:
	print("timeout")
	timer.stop()
	exhausted = true
	var timeline: DialogicTimeline = Globals.create_timeline_text("Ughh, i'm exhausted !")
	Dialogic.start(timeline)
	Dialogic.timeline_ended.connect(_on_timeline_ended, ConnectFlags.CONNECT_ONE_SHOT)

func _on_timeline_ended() -> void:
	exhausted = false
	transition_to(idle_state)
