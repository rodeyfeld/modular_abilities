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
			print(action.action_type)
			for int_field in action.int_fields:
				print(int_field.name)
			print(action.get("action_type"))
			var action_script = load(DataDrivenAbilitySingleton.action_type_map[action.action_type])
			var base_action = action_script.new()
			print(base_action)
			
			ability.event_register[ability_event.event_type].append(base_action)
	return ability
	
