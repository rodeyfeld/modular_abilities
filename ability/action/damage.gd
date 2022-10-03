extends BaseAction

var amount:int

func setup(data:AbilityActionData):
	for field in self.data.int_fields:
		if field.name == 'amount':
			amount = field.value

func execute(caster_ability:Ability, target:Entity, target_point:Vector2):
	target.update_hp(-amount, caster_ability.caster.name)

