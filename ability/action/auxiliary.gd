extends BaseAction

var ability:Ability
var data_driven_ability_script = load("res://ability/data_driven_ability.gd")

# Auxiliary actions are actions that contain another ability to be fired 
# when the event register is called

func setup(data_param:AbilityActionData):
	super(data_param)

	# Parse the new ability and set the internal ability to it
	var data_driven_ability = data_driven_ability_script.new()
	# TODO: Support multiple ablities to be added here
	ability = data_driven_ability.parse(self.data.trigger_abilities[0])

func execute(caster_ability:Ability, target:Actor, _target_point:Vector2):
	# Add the ability to the caster's tree
	# The target is the caster of the ability
	var caster = target
	var data_driven_ability = data_driven_ability_script.new()
	ability = data_driven_ability.parse(self.data.trigger_abilities[0])
	caster.add_child(ability)
	# If the ability is null, set it to repeat the current ability. 
	if !ability:
		ability = caster_ability
	# Attempt to execute the ability with updated params
	ability.execute(caster, {'target_unit':target, 'target_position': _target_point})
