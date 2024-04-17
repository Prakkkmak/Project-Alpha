extends CanvasLayer

@export var timeline: DialogicTimeline

@onready var black_screen: ColorRect = %BlackScreen


func _ready() -> void:
	_shade_off()
	await get_tree().create_timer(3.0).timeout
	if timeline:
		Dialogic.start(timeline)
		Dialogic.timeline_ended.connect(_on_timeline_ended, ConnectFlags.CONNECT_ONE_SHOT)

func _shade_off() -> void:
	var tween: Tween = get_tree().create_tween()
	# https://easings.net/
	tween.tween_property(black_screen, "color:a", 0.0, 4).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD).set_delay(1)
	tween.tween_callback(black_screen.queue_free)

func _on_timeline_ended() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/screens/title_screen/title_screen.tscn")
