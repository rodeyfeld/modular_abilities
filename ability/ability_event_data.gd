extends Resource

class_name AbilityEventData

enum event_types {
	NONE,
	ON_SPELL_START,
	ON_ABILITY_START,
}

@export var event_type:event_types = event_types.ON_ABILITY_START
@export var actions:Array[AbilityActionData] = []
@export var modifiers:Array[AbilityModifierData] = []
