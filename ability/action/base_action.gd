extends Node

class_name BaseAction

var data:AbilityActionData

func setup(data:AbilityActionData):
	self.data = data
	pass
	
func execute(caster_ability:Ability, target:Entity, target_point:Vector2):
	pass

