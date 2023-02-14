extends Node

class_name BaseAction

var data:AbilityActionData
var action_execution_num_timer:Timer = null

signal action_completed

func setup(data_param:AbilityActionData):
	self.data = data_param
	pass

func execute_all(_caster_ability:Ability, _target:Actor, _target_point:Vector2):
	for num in range(self.data.attribute_fields.attribute_field_fire_data.num_execution):
		print("exec_num: ", num)
		action_execution_num_timer.start(self.data.attribute_fields.attribute_field_fire_data.time_between_execution)
		self.execute(_caster_ability, _target, _target_point)
		await action_execution_num_timer.timeout
	print(_caster_ability.caster.title)
	#TODO: Make this not awful
	if _caster_ability.caster.title == 'thinker':
		_caster_ability.caster.queue_free()
	emit_signal("action_completed")
		
func execute(_caster_ability:Ability, _target:Actor, _target_point:Vector2):
	pass
