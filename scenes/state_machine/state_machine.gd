class_name StateMachine extends Node


@export var initial_state: State
@export var process_input: bool = false

var current_state: State


func _ready() -> void:
	for child: Node in get_children():
		if child is State:
			var state: State = child as State
			state.transitioned.connect(_on_child_transition)
			if child.has_method("set_process_input_enabled"):
				child.call("set_process_input_enabled", process_input)
	if initial_state:
		transition(null, initial_state)


func _process(delta: float) -> void:
	if current_state:
		current_state._update(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state._physics_update(delta)


func _input(event: InputEvent) -> void:
	if process_input && current_state:
		current_state._input_process(event)


func transition(from_state: State, to_state: State) -> void:
	if from_state != current_state:
		return
	
	if !to_state:
		return
	
	if current_state:
		current_state._exit()
	
	to_state._enter()
	
	current_state = to_state
	print("New state:" + current_state.name)


func _on_child_transition(from_state: State, to_state: State) -> void:
	transition.call_deferred(from_state, to_state)
