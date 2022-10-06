extends BaseAction

var amount:int

func setup(data_param:AbilityActionData):
	super(data_param)
	for field in self.data.int_fields:
		if field.name == 'amount':
			amount = field.value

func execute(caster_ability:Ability, target:Entity, _target_point:Vector2):
	target.update_health(-amount, caster_ability.caster.name)
