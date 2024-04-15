extends CharacterBody2D

@export var data: NpcData

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var interactable_component: InteractableComponent = $InteractableComponent

func _ready() -> void:
	# Initialisation de la texture du sprite
	sprite.texture = data.idle_texture
	# Connecter les signaux d'animation
	connect_animation_signals()
	setup_interactable_component()

func connect_animation_signals() -> void:
	# Connecter le signal 'animation_changed' à une méthode de gestion
	animation_player.animation_changed.connect(_on_AnimationPlayer_animation_changed)

func _on_AnimationPlayer_animation_changed(old_name: String, new_name: String) -> void:
	# Changer la texture du sprite en fonction du nom de l'animation jouée
	if "idle" in new_name:
		sprite.texture = data.idle_texture
	elif "walk" in new_name:
		sprite.texture = data.walk_texture

func setup_interactable_component() -> void:
	# Configuration spécifique si l'interaction est de type TalkInteraction
	if interactable_component.interaction is TalkInteraction:
		(interactable_component.interaction as TalkInteraction).npc_data = data
