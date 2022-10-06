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
@onready var cooldown_timer = $CooldownTimer

var ability_data:AbilityData
var caster:Entity
var targets:Dictionary
var event_register:Dictionary = {}
var is_running:bool
var is_cast:bool
var cast_point:Vector2
var target_position:Vector2
var target_unit:Entity
var channelled:bool = false:
	get:
		return (ability_data.behavior_flags & DataDrivenAbilitySingleton.behavior_flag.CHANNELLED) != 0
	set(value):
		channelled = value


func setup(data:AbilityData):
	ability_data = data
	targets = {
		'target_unit': null,
		'target_position': null
	}
	event_register[DataDrivenAbilitySingleton.event_types.ON_ABILITY_START] = []
	event_register[DataDrivenAbilitySingleton.event_types.ON_SPELL_START] = []
	event_register[DataDrivenAbilitySingleton.event_types.ON_PROJECTILE_HIT] = []
	
func execute(caster_param:Actor, target_dict_param:Dictionary):
	caster = caster_param
	targets = target_dict_param
	is_running = true
	cast_point = caster_param.position
	target_unit = target_dict_param['target_unit']
	target_position = target_dict_param['target_position']
	
	if event_register[DataDrivenAbilitySingleton.event_types.ON_ABILITY_START] != []:
		print("RUNNING event_types.ON_ABILITY_START")
		perform_actions(event_register[DataDrivenAbilitySingleton.event_types.ON_ABILITY_START])
	if channelled:
		pass
	else:
		await on_spell_start()
		
func perform_actions(actions:Array):
	# TODO: May need to make awaits signal based
	for action in actions:
		if action.data.target == DataDrivenAbilitySingleton.target.CASTER:
			await action.execute(self, caster, target_position)
		elif action.data.target == DataDrivenAbilitySingleton.target.POINT:
			await action.execute(self, null, target_position)
		elif action.data.target == DataDrivenAbilitySingleton.target.TARGET:
			await action.execute(self, targets[0], target_position)

func on_spell_start():
	cooldown_timer.start()
	is_cast = true
#	targets.append(target_unit)
	await perform_actions(event_register[DataDrivenAbilitySingleton.event_types.ON_SPELL_START])
		
func on_projectile_hit(target:Actor):
	if event_register[DataDrivenAbilitySingleton.event_types.ON_PROJECTILE_HIT] != []:
		for action in event_register[DataDrivenAbilitySingleton.event_types.ON_PROJECTILE_HIT]:
			await action.execute(self, target, target.position)
		if ability_data.num_repeat > 0:
		#	ability.execute(self, {'target_unit':self, 'target_position': get_global_mouse_position()})
			var new_target_position:Vector2 = target.nearby_allied_units.pop_front().global_position
			await execute(target, {'target_unit':target, 'target_position': new_target_position})
