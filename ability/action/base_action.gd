extends Node

class_name BaseAction

var data:AbilityActionData


func setup(data_param:AbilityActionData):
	self.data = data_param
	pass
	
func execute(_caster_ability:Ability, _target:Actor, _target_point:Vector2):
	pass

