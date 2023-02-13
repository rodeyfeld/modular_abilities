extends Node

class_name BaseAction

var data:AbilityActionData


func setup(data_param:AbilityActionData):
	self.data = data_param
	pass

func execute_all(_caster_ability:Ability, _target:Actor, _target_point:Vector2):
	for num in range(self.data.attribute_fields.num_execution):
		self.execute(_caster_ability, _target, _target_point)

func execute(_caster_ability:Ability, _target:Actor, _target_point:Vector2):
	pass

