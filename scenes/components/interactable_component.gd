@tool
class_name InteractableComponent extends Area2D

signal interaction_ended
signal interaction_resolved
signal interaction_failed

@export var interaction: Interaction
@export var icon_sprite_texture: Texture2D
@export var icon_position: Vector2 = Vector2(0, -50)
@export var show_interact_key_on_hover: bool = true

@export var interaction_condition: String

@onready var icon: Sprite2D = $Icon
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_active: bool = true

func _ready() -> void:
	if icon_sprite_texture:
		icon.texture = icon_sprite_texture
	if icon_position:
		icon.position = icon_position
	if interaction.condition:
		interaction_condition = interaction.condition
	if interaction_condition:
		is_active = false
	GameState.state_changed.connect(_on_game_state_changed)


func interact(source: Area2D) -> void:
	if !is_active:
		interaction_ended.emit()
		return
	
	if !interaction:
		return

	interaction.ended.connect(func() -> void: interaction_ended.emit())
	interaction.failed.connect(func() -> void: interaction_failed.emit())
	interaction.resolved.connect(func() -> void: interaction_resolved.emit())

	interaction.call("perform_interaction", source, self)


func show_interact_key(value: bool) -> void:
	if !is_active:
		return
	
	if !show_interact_key_on_hover:
		return
	
	if value:
		icon.visible = true
		animation_player.play("pop_in")
	else:
		animation_player.play("pop_off")


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	if !interaction:
		warnings.append("No interaction set")
	return warnings


func _on_game_state_changed(state: String, value: bool) -> void:
	if interaction_condition && interaction_condition.to_lower() == state.to_lower():
		is_active = value
