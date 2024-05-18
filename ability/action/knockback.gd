extends BaseAction

var amount:float

func setup(data_param:AbilityActionData):
	super(data_param)
	amount = self.data.attribute_fields.amount

func execute(caster_ability:Ability, target:Actor, _target_point:Vector2):
	# When this is executed, knock the target back
	target.push_body(amount, caster_ability.caster.global_position, caster_ability.caster.name)
