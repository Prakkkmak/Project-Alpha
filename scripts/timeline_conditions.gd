class_name TimelineCondition extends Resource

@export var name: String
@export var conditions: Array[GameStateCondition]
@export var timeline: DialogicTimeline


func are_conditions_met() -> bool:
	for condition: GameStateCondition in conditions:
		if GameState.get_state(condition.state) != condition.value:
			return false
	return true
