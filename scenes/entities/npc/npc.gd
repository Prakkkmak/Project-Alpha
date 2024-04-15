extends CharacterBody2D

@export var data: NpcData

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var interactable_component: InteractableComponent = $InteractableComponent

func _ready() -> void:
	sprite.texture = data.idle_texture
	duplicate_animation_libraries()
	setup_animations()
	setup_interactable_component()

func duplicate_animation_libraries() -> void:
	var libraries: Array[StringName] = animation_player.get_animation_library_list()
	for i: int in range(libraries.size()):
		var library_name: String = libraries[i]
		var library: AnimationLibrary = animation_player.get_animation_library(library_name).duplicate(true)
		var new_library_name: String = "{0}_{1}".format(library_name, str(i))  # Création d'un nom unique
		animation_player.remove_animation_library(library_name)
		animation_player.add_animation_library(new_library_name, library)

func setup_animations() -> void:
	var anim_list: PackedStringArray = animation_player.get_animation_list()
	for anim_name: String in anim_list:
		var anim: Animation = animation_player.get_animation(anim_name)
		if anim:
			var track_no: int = anim.find_track("Sprite2D:texture", Animation.TYPE_VALUE)
			anim.track_insert_key(track_no, 0, data.idle_texture if "idle" in anim_name else data.walk_texture)

func setup_interactable_component() -> void:
	if interactable_component.interaction is TalkInteraction:
		(interactable_component.interaction as TalkInteraction).npc_data = data
