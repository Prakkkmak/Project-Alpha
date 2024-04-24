extends Node2D

@export var dungeon_conditions: Array[String] = [
	"edmund_help_gold_completed",
	"violet_help_open_completed"
]
@export var dungeon_opened_event: String = "dungeon_opened"

func _ready() -> void:
	GameState.state_changed.connect(_on_state_changed)
	for dungeon_condition: String in dungeon_conditions:
		if GameState.get_state(dungeon_condition):
			GameState.set_state(dungeon_opened_event, true)
			#HACK
			var npcs: Array[Node] = get_tree().get_nodes_in_group("npc")
			for node: Node in npcs:
				var npc: Npc = node as Npc
				if npc.data.name == "Edmund":
					npc.position = npc.data.new_position


func _on_state_changed(state: String, value: bool) -> void:
	for dungeon_condition: String in dungeon_conditions:
		if dungeon_condition == state:
			GameState.set_state(dungeon_opened_event, true)
			#HACK
			var npcs: Array[Node] = get_tree().get_nodes_in_group("npc")
			for node: Node in npcs:
				var npc: Npc = node as Npc
				if npc.data.name == "Edmund":
					npc.position = npc.data.new_position
