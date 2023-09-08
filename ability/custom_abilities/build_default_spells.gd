extends Node

const data_driven_ability_class = preload("res://ability/data_driven_ability.gd")
const ability_data_class = preload("res://ability/ability_data.gd")
const ability_event_data_class = preload("res://ability/ability_event_data.gd")
const ability_action_data_class = preload("res://ability/ability_action_data.gd")
const attribute_data_class = preload("res://ability/fields/attribute_data.gd")
const attribute_field_fire_data_class = preload("res://ability/fields/attribute_field_fire_data.gd")

var basic_abilities = {
	'nova': null
}


func setup():
	
	#Nova Spell
	
	var data_driven_ability:DataDrivenAbility = data_driven_ability_class.new()
	# Assign general ability data
	data_driven_ability.ability_data = ability_data_class.new()
	data_driven_ability.ability_event_data = []
	# Assign first event data list
	var ability_event_data_0:AbilityEventData = ability_event_data_class.new()
	ability_event_data_0.event_type = DataDrivenAbilitySingleton.event_types.ON_ABILITY_START
	ability_event_data_0.actions = []
	var ability_action_data_0 = ability_action_data_class.new()
	ability_action_data_0.action_type = DataDrivenAbilitySingleton.action_type.LINEAR_PROJECTILE
	ability_action_data_0.target_type = DataDrivenAbilitySingleton.target_type.POINT
	#Setup attribute data 
	ability_action_data_0.attribute_fields = attribute_data_class.new()
	ability_action_data_0.attribute_fields.speed = 50
	#Setup firefield data
	ability_action_data_0.attribute_fields.attribute_field_fire_data = attribute_field_fire_data_class.new() 
	ability_action_data_0.attribute_fields.attribute_field_fire_data.time_between_execution = .2
	ability_action_data_0.attribute_fields.attribute_field_fire_data.num_execution = 3
	ability_action_data_0.attribute_fields.attribute_field_fire_data.num_to_fire_per_execution = 10
	ability_action_data_0.attribute_fields.attribute_field_fire_data.timeout = 3
	ability_event_data_0.actions.append(ability_action_data_0)
	data_driven_ability.ability_event_data.append(ability_event_data_0)
	print(data_driven_ability)
	basic_abilities['nova'] = data_driven_ability.parse(data_driven_ability)
	
	
