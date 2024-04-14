class_name OptionsMenu extends VBoxContainer
signal quitted

@onready var back_button: TextureButton = %BackButton


func _ready() -> void:
	back_button.pressed.connect(_on_back_button_pressed)

func _on_back_button_pressed() -> void:
	quitted.emit()

