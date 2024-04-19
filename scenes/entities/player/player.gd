class_name Player extends CharacterBody2D

@export var idle_texture: Texture
@export var walk_texture: Texture

@export_category("Floor Sounds")
@export var grass_step_sounds: AudioStreamRandomizer
@export var stone_step_sounds: AudioStreamRandomizer
@export var wooden_step_sounds: AudioStreamRandomizer
@export var mud_step_sounds: AudioStreamRandomizer

@onready var move_component: MoveComponent = $MoveComponent
@onready var interaction_component: Area2D = $InteractionComponent
@onready var interaction_distance: float = interaction_component.position.length()
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var step_sounds_audio_stream_player: AudioStreamPlayer2D = %StepSoundAudioStreamPlayer


func _ready() -> void:
	for anim_name: String in animation_player.get_animation_list():
		var anim: Animation = animation_player.get_animation(anim_name)
		if anim:
			var track_no: int = anim.find_track("Sprite2D:texture", Animation.TYPE_VALUE)
			print(track_no)
			anim.track_insert_key(track_no, 0, idle_texture if "idle" in anim_name else walk_texture)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dialog_open"):
		Dialogic.start('first_timeline')
		get_viewport().set_input_as_handled()

var last_ground_type: String = ""

func _physics_process(delta: float) -> void:
	var new_interaction_component_position: Vector2 = move_component.get_direction() * interaction_distance
	if new_interaction_component_position.length() > 0:
		interaction_component.position = new_interaction_component_position
	
	var tile_map: TileMap = get_parent().find_child("TileMap") as TileMap
	
	if !tile_map:
		return
	
	var player_position: Vector2 = position
	var tile_position: Vector2 = tile_map.local_to_map(player_position)
	var tile_data: TileData = tile_map.get_cell_tile_data(0, tile_position)
	
	if !tile_data:
		return
	
	var ground_type: String = tile_data.get_custom_data("ground_type") as String
	
	if !ground_type:
		return
		
	var step_sounds: Dictionary = {
		"grass": grass_step_sounds,
		"stone": stone_step_sounds,
		"wooden": wooden_step_sounds,
		"dirt": mud_step_sounds,
	}
	
	if step_sounds[ground_type] && last_ground_type != ground_type:
		step_sounds_audio_stream_player.stream = step_sounds[ground_type]
		last_ground_type = ground_type
