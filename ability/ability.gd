extends Node2D

class_name Ability
#
#const ON_ABILITY_START:String = "ON_ABILITY_START"
#const ON_SPELL_START:String = "ON_SPELL_START"
#const ON_CHANNEL_INTERRUPTED:String = "ON_CHANNEL_INTERRUPTED"
#const ON_CHANNEL_SUCCEED:String = "ON_CHANNEL_SUCCEED"
#const ON_PROJECTILE_HIT_UNIT:String = "ON_PROJECTILE_HIT_UNIT"
#const ON_TARGET_DIED:String = "ON_TARGET_DIED"
#const ON_UPGRADE:String = "ON_UPGRADE"

var ability_data:AbilityData
var caster:Entity
var targets:Array
var event_register:Dictionary = {}
var is_running:bool
var cast_point:Vector2
var target_point:Vector2
var target_unit:Entity

func setup(data:AbilityData):
	ability_data = data
	targets = []
	event_register[DataDrivenAbilitySingleton.event_types.ON_ABILITY_START] = []
	
func execute(caster_param:Entity, target_param:Array):
	caster = caster_param
	targets = target_param
	is_running = true
	cast_point = caster_param.position
	target_unit = target_param[0]
	target_point = target_param[1]
	
	if event_register[DataDrivenAbilitySingleton.event_types.ON_ABILITY_START] != null:
		print("Okay starting")
		perform_actions(event_register[DataDrivenAbilitySingleton.event_types.ON_ABILITY_START])
	
func perform_actions(actions:Array):
	# TODO: May need to make awaits signal based
	for action in actions:
		print(action)
		if action.data.target == DataDrivenAbilitySingleton.target.CASTER:
			action.execute(self, caster, target_point)
		elif action.data.target == DataDrivenAbilitySingleton.target.POINT:
			await action.execute(self, targets[0], target_point)
	
