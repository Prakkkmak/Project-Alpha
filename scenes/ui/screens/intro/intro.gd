extends CanvasLayer

@export var seconds: int = 10
@export_file("*.tscn") var scene_file: String = "res://scenes/main/main.tscn"

@onready var label: Label = %IntroLabel
@onready var original_text: String = ""
@onready var continue_button: Button = $PanelContainer/VBoxContainer/ContinueButton

func _ready() -> void:
	original_text = label.text
	label.text = ""
	wrote_text()
	continue_button.pressed.connect(_on_button_pressed)


func wrote_text() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(label, "text", original_text, 4)
	tween.tween_callback(continue_button.show)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(scene_file)
