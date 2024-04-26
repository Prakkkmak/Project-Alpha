extends CanvasLayer


@export_file("*.tscn") var scene_file: String = "res://scenes/ui/screens/intro/intro.tscn"

@onready var main_menu: TextureRect = %MainMenu
@onready var play_button: Button = %PlayButton
@onready var options_button: Button = %OptionsButton
@onready var options_menu: OptionsMenu = %OptionsMenu
@onready var music_button_disabled: TextureButton = %MusicButtonDisable
@onready var main_music: AudioStreamPlayer = $MainMusic


func _ready() -> void:
	options_button.pressed.connect(_on_options_button_pressed)
	options_menu.quitted.connect(_on_options_menu_quitted)
	play_button.pressed.connect(_on_play_button_pressed)
	music_button_disabled.toggled.connect(_on_music_button_disabled_toggled)


func _on_options_button_pressed() -> void:
	main_menu.hide()
	options_menu.show()


func _on_options_menu_quitted() -> void:
	options_menu.hide()
	main_menu.show()


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file(scene_file)


func _on_music_button_disabled_toggled(toggled_on: bool) -> void:
	main_music.playing = !toggled_on
