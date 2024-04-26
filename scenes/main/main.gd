extends Node

@export var end_screen: PackedScene
@export var override_level: PackedScene
@export var states_acquiered: Array[String] = []
@export var debug: bool = false

@export_category("conditions")
@export var end_condition: String = "crown_acquired_completed"

@onready var current_level: Node2D = %ForestLevel
@onready var player: Player = %Player
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var level_displayer: LevelDisplayer = %LevelDisplayer
@onready var debug_panel: PanelContainer = $CanvasLayer/MarginContainer/DebugPanel
@onready var main_camera: MainCamera = %MainCamera


const ANIM_FADE_OFF: String = "fade_off"

func _ready() -> void:
	GameState.state_changed.connect(_on_state_changed)
	_connect_level_teleporters()
	remove_child(player)
	current_level.add_child(player)
	if override_level:
		_on_player_teleport_requested(override_level, Vector2.ZERO)
	if debug:
		debug_panel.show()
		for state_acquiered: String in states_acquiered:
			GameState.set_state(state_acquiered, true)
	else:
		debug_panel.hide()
	level_displayer.display_level(current_level.name)


func end_game() -> void:
	get_tree().change_scene_to_packed(end_screen)
	GameState.clear()


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
	if new_level:
		current_level.remove_child(player)
		remove_child(current_level)
		current_level.queue_free()
		current_level = new_level.instantiate()
		current_level.add_child(player)
		add_child(current_level)
	player.global_position = player_position
	main_camera.global_position = player_position
	animation_player.play("fade_in")
	animation_player.animation_finished.connect(_on_fade_in_finished, ConnectFlags.CONNECT_ONE_SHOT)
	_connect_level_teleporters()

func _on_fade_in_finished(_name: String) -> void:
	level_displayer.display_level(current_level.name)
	pass
