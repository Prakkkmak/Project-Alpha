class_name NpcData extends Resource


@export var name: String
@export var description: String

@export_category("Textures")
@export var idle_texture: Texture
@export var walk_texture: Texture

@export_category("Timelines")
@export var greetings_timeline: DialogicTimeline
@export var talk_timeline: DialogicTimeline
@export var help_timeline: DialogicTimeline

@export_category("Help Conditions")
@export var true_conditions: Array[String]
@export var false_conditions: Array[String]
