class_name TalkInteraction extends Interaction

@export var npc_data: NpcData
const LITTLE_KING_CHARACTER: DialogicCharacter = preload("res://resources/dialogic/characters/little_king.dch")

func perform_interaction(source: Area2D, target: Area2D) -> void:
	# Vérifie si le salut initial a déjà eu lieu
	var greeted_state_name: String = npc_data.name+ "_greeted"
	var greeted: bool = GameState.get_state(greeted_state_name)
	if not greeted:
		_start_timeline(npc_data.greetings_timeline, greeted_state_name, source, target)
	else:
		for condition: TimelineCondition in npc_data.conditions:
			if condition.are_conditions_met():
				var state_name: String = npc_data.name + "_" + condition.name + "_completed"
				_start_timeline(condition.timeline, state_name, source, target, true)
				for c: GameStateCondition in condition.conditions:
					if c.value:
						GameState.use_state(c.state)
				return
		# Si aucune condition n'est remplie, lancer la timeline de conversation par défault
		var talked_state_name: String = npc_data.name + "_talked"
		_start_timeline(npc_data.talk_timeline, talked_state_name, source, target)

func _start_timeline(timeline: DialogicTimeline, state_name: String, _source: Area2D, _target: Area2D, is_resolve: bool = false) -> void:
	Dialogic.start(timeline)
	Dialogic.timeline_ended.connect(_on_timeline_ended.bind(state_name, is_resolve), ConnectFlags.CONNECT_ONE_SHOT)

func _on_timeline_ended(state_to_update: String, is_resolve: bool = false) -> void:
	GameState.set_state(state_to_update)
	ended.emit()
	if is_resolve:
		resolved.emit()


