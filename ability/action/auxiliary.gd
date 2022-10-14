extends BaseAction

var ability:Ability
var data_driven_ability_script = load("res://ability/data_driven_ability.gd")

func setup(data_param:AbilityActionData):
	super(data_param)
	print("setting up", data_param)
	
	var data_driven_ability = data_driven_ability_script.new()
	ability = data_driven_ability.parse(self.data.trigger_abilities[0])

func execute(caster_ability:Ability, target:Actor, _target_point:Vector2):
	caster_ability.caster.add_child(ability)
	if !ability:
		ability = caster_ability
	ability.execute(caster_ability.caster, {'target_unit':target, 'target_position': _target_point})
