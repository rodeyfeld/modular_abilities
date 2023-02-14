extends Node

class_name BaseAction

var data:AbilityActionData
var action_execution_num_timer:Timer = null

func setup(data_param:AbilityActionData):
	self.data = data_param
	pass

func execute_all(_caster_ability:Ability, _target:Actor, _target_point:Vector2):
	for num in range(self.data.attribute_fields.attribute_field_fire_data.num_execution):
		print("exec_num: ", num)
		action_execution_num_timer.start(self.data.attribute_fields.attribute_field_fire_data.time_between_execution)
		self.execute(_caster_ability, _target, _target_point)
		await action_execution_num_timer.timeout
		print("hit timeout")
		
func execute(_caster_ability:Ability, _target:Actor, _target_point:Vector2):
	pass
