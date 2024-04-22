extends Node

@export var end_screen: PackedScene
@export var end_condition: String = "crown_acquired"
@export var override_level: PackedScene

@onready var current_level: Node2D = %Level
@onready var player: Player = %Player
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var level_displayer: LevelDisplayer = %LevelDisplayer


const ANIM_FADE_OFF: String = "fade_off"

func _ready() -> void:
	GameState.state_changed.connect(_on_state_changed)
	_connect_level_teleporters()
	remove_child(player)
	current_level.add_child(player)
	if override_level:
		_on_player_teleport_requested(override_level, Vector2.ZERO)


func end_game() -> void:
	get_tree().change_scene_to_packed(end_screen)


func _connect_level_teleporters() -> void:
	for child: Node in current_level.get_children():
		if child is SceneTeleporter:
			(child as SceneTeleporter).player_teleport_requested.connect(_on_player_teleport_requested, ConnectFlags.CONNECT_ONE_SHOT)


func _on_state_changed(state: String, value: bool) -> void:
	if state == end_condition && value:
		end_game()


func _on_player_teleport_requested(new_level: PackedScene, player_position: Vector2) -> void:
	animation_player.play("fade_off")
	animation_player.animation_finished.connect(_on_fade_off_finished.bind(new_level, player_position), ConnectFlags.CONNECT_ONE_SHOT)


func _on_fade_off_finished(_name: String, new_level: PackedScene, player_position: Vector2) -> void:
	current_level.remove_child(player)
	remove_child(current_level)
	current_level.queue_free()
	current_level = new_level.instantiate()
	player.global_position = player_position
	current_level.add_child(player)
	add_child(current_level)
	animation_player.play("fade_in")
	animation_player.animation_finished.connect(_on_fade_in_finished, ConnectFlags.CONNECT_ONE_SHOT)
	
	_connect_level_teleporters()

func _on_fade_in_finished(_name: String) -> void:
	level_displayer.display_level(current_level.name)
	pass
