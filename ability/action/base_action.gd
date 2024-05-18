extends Node

class_name BaseAction
var data_driven_ability_script = load("res://ability/data_driven_ability.gd")

var data:AbilityActionData
var execution_iteration_timer:Timer = null


func setup(data_param:AbilityActionData):
	self.data = data_param
	execution_iteration_timer = Timer.new()
	execution_iteration_timer.autostart = true


func execute_all(_caster_ability:Ability, _target:Actor, _target_point:Vector2):
	#TODO: Change this so non projectiles don't need fire field data
	for num in range(self.data.attribute_fields.attribute_field_fire_data.num_execution):
		execution_iteration_timer.start(self.data.attribute_fields.attribute_field_fire_data.time_between_execution)
		self.execute(_caster_ability, _target, _target_point)
		await execution_iteration_timer.timeout
	_caster_ability.emit_signal("ability_action_finished")
		
func execute(_caster_ability:Ability, _target:Actor, _target_point:Vector2):
	pass
