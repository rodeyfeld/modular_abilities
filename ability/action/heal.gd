extends BaseAction

var amount:int

func setup(data_param:AbilityActionData):
	super(data_param)
	# TODO: Replace this with dictionary
	for field in self.data.int_fields:
		if field.name == 'amount':
			amount = field.value

func execute(caster_ability:Ability, target:Actor, _target_point:Vector2):
	# When this is executed, update the target's health
	target.update_health(amount, caster_ability.caster.name)
