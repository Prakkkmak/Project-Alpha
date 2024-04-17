extends CanvasLayer


@export var main_scene: PackedScene


@onready var main_menu: TextureRect = %MainMenu
@onready var play_button: Button = %PlayButton
@onready var options_button: Button = %OptionsButton
@onready var options_menu: OptionsMenu = %OptionsMenu


func _ready() -> void:
	options_button.pressed.connect(_on_options_button_pressed)
	options_menu.quitted.connect(_on_options_menu_quitted)
	play_button.pressed.connect(_on_play_button_pressed)
	

func _on_options_button_pressed() -> void:
	main_menu.hide()
	options_menu.show()

func _on_options_menu_quitted() -> void:
	options_menu.hide()
	main_menu.show()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_scene)
