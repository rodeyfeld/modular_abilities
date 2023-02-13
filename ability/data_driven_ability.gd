extends Resource

class_name DataDrivenAbility

# Core class for Data Driven Abilities


const ability_scene = preload("res://ability/ability.tscn")
const base_action_scene = preload("res://ability/action/base_action.tscn")

@export var ability_data:AbilityData
@export var ability_event_data:Array[AbilityEventData]


func parse(raw_ability:DataDrivenAbility) -> Ability:
	# Create the new scene for the ability
	var ability:Ability = ability_scene.instantiate()
	# Setup basic ability data 
	ability.setup(raw_ability.ability_data)
	# For every event in our data driven ability, we want its actions to be added
	# to the register for that ability. These will be cycled through on ability
	# cast by an actor
	for ability_event in raw_ability.ability_event_data:
		for action in ability_event.actions:
			# We check the file required for this type of ability, and load the 
			# relevant script for this action from DataDrivenAbilitySingleton.action_type_map
			var action_script = load(DataDrivenAbilitySingleton.action_type_map[action.action_type])
			var base_action:BaseAction = base_action_scene.instantiate()
			base_action.set_script(action_script)
			# Configure the new action based on the fields from DataDrivenAbility
			base_action.setup(action)
			# Register the action to the abilities event register
			ability.event_register[ability_event.event_type].append(base_action)
	return ability
