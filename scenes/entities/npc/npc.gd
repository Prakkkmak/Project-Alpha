@tool
class_name Npc extends CharacterBody2D

@export var data: NpcData
@export var teleportation_location_on_resolve: Vector2


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var debug_name: Label = %DebugName

func _ready() -> void:
	if not Engine.is_editor_hint():
		debug_name.hide()  
	else:
		debug_name.show()  
		debug_name.text = data.name
	# Initialisation de la texture du sprite
	sprite.texture = data.idle_texture
	# Connecter les signaux d'animation
	connect_animation_signals()
	setup_interactable_component()

func connect_animation_signals() -> void:
	# Connecter le signal 'animation_changed' à une méthode de gestion
	animation_player.animation_changed.connect(_on_animation_player_animation_changed)


func setup_interactable_component() -> void:
	# Configuration spécifique si l'interaction est de type TalkInteraction
	if interactable_component.interaction is TalkInteraction:
		(interactable_component.interaction as TalkInteraction).npc_data = data
		(interactable_component.interaction as TalkInteraction).resolved.connect(_on_npc_resolve)


func _on_animation_player_animation_changed(old_name: String, new_name: String) -> void:
	# Changer la texture du sprite en fonction du nom de l'animation jouée
	if "idle" in new_name:
		sprite.texture = data.idle_texture
	elif "walk" in new_name:
		sprite.texture = data.walk_texture


func _on_npc_resolve() -> void:
	if data.next_data:
		global_position =  data.new_position
		data = data.next_data


