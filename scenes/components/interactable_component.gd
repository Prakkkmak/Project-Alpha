@tool
class_name InteractableComponent extends Area2D


@export var interaction: Interaction
@export var icon_sprite_texture: Texture2D
@export var icon_position: Vector2 = Vector2(0, -50)
@export var show_interact_key_on_hover: bool = true

@onready var icon: Sprite2D = $Icon

func _ready() -> void:
	if icon_sprite_texture:
		icon.texture = icon_sprite_texture
	if icon_position:
		icon.position = icon_position


func interact(source: Area2D) -> void:
	if !interaction:
		return
	interaction.call("perform_interaction", source, self)


func show_interact_key(show: bool) -> void:
	if !show_interact_key_on_hover:
		return
	icon.visible = show


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	if !interaction:
		warnings.append("No interaction set")
	return warnings
