class_name TalkInteraction extends Interaction

@export var npc_data: NpcData

func perform_interaction(source: Area2D, target: Area2D) -> void:
	var greeted_state_name: String = npc_data.name + "_greeted"
	var greeted: bool = GameState.get_state(greeted_state_name)
	if !greeted:
		Dialogic.start(npc_data.greetings_timeline)
		Dialogic.timeline_ended.connect(_on_timeline_ended.bind(greeted_state_name), ConnectFlags.CONNECT_ONE_SHOT)
	else:
		var true_conditions_all_meet: bool = npc_data.true_conditions.all(func(condition: String) -> bool: return GameState.get_state(condition))
		var false_conditions_all_meet: bool = npc_data.false_conditions.all(func(condition: String) -> bool: return !GameState.get_state(condition))
		if true_conditions_all_meet && false_conditions_all_meet:
			var helped_state_name: String = npc_data.name + "_helped"
			Dialogic.start(npc_data.help_timeline)
			Dialogic.timeline_ended.connect(_on_timeline_ended.bind(helped_state_name), ConnectFlags.CONNECT_ONE_SHOT)
		else:
			var talked_state_name: String = npc_data.name + "_talked"
			Dialogic.start(npc_data.talk_timeline)
			Dialogic.timeline_ended.connect(_on_timeline_ended.bind(talked_state_name), ConnectFlags.CONNECT_ONE_SHOT)


func _on_timeline_ended(state_to_update: String) -> void:
	GameState.set_state(state_to_update)
	ended.emit()
