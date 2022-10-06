extends Resource

class_name DataDrivenAbility

const ability_scene = preload("res://ability/ability.tscn")


@export var ability_data:AbilityData
@export var ability_event_data:Array[AbilityEventData]
@export var test_:int


func parse(raw_ability:DataDrivenAbility) -> Ability:
	var ability:Ability = ability_scene.instantiate()
	ability.setup(raw_ability.ability_data)
	for ability_event in raw_ability.ability_event_data:
		for action in ability_event.actions:
			var action_script = load(DataDrivenAbilitySingleton.action_type_map[action.action_type])
			var base_action:BaseAction = action_script.new()
			base_action.setup(action)
			ability.event_register[ability_event.event_type].append(base_action)
	return ability
