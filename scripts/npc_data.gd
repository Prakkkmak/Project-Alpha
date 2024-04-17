class_name NpcData extends Resource

@export var name: String
@export var description: String

@export_category("Textures")
@export var idle_texture: Texture
@export var walk_texture: Texture

@export_category("Dialogic")
@export var character: DialogicCharacter
@export var greetings_timeline: DialogicTimeline
@export var talk_timeline: DialogicTimeline

@export_category("Conditions")
@export var conditions: Array[TimelineCondition]
