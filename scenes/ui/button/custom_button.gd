class_name CustomButton extends Button

func _ready() -> void:
	var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
	pressed.connect(audio_stream_player.play)
