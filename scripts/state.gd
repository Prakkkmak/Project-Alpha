class_name State extends Node


signal transitioned(from_state: State, to_state: State)


func _enter() -> void:
	pass


func _exit() -> void:
	pass


func _update(delta: float) -> void:
	pass


func _physics_update(delta: float) -> void:
	pass


func _input_process(event: InputEvent) -> void:
	pass


func transition_to(state: State) -> void:
	transitioned.emit(self, state)
