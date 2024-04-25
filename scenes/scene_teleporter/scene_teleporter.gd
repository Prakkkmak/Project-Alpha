class_name SceneTeleporter extends Area2D


signal player_teleport_requested(level_scene: PackedScene, position: Vector2)

@export_file("*.tscn") var new_level_path: String
@export var starting_position: Vector2
@export var state_requirement: String
 
var new_level_scene: PackedScene

func _ready() -> void:
	new_level_scene = load(new_level_path)
	body_entered.connect(_on_body_entered)


func teleport() -> void:
	if !state_requirement || GameState.get_state(state_requirement):
		player_teleport_requested.emit(new_level_scene, starting_position)


func _on_body_entered(node: Node2D) -> void:
	if node is Player:
		teleport()
