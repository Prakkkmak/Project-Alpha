extends CharacterBody2D


@export var data: NpcData

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	sprite.texture = data.idle_texture
	for anim_name: String in animation_player.get_animation_list():
		var anim: Animation = animation_player.get_animation(anim_name)
		if anim:
			var track_no: int = anim.find_track("Sprite2D:texture", Animation.TYPE_VALUE)
			anim.track_insert_key(track_no, 0, data.idle_texture if "idle" in anim_name else data.walk_texture)
