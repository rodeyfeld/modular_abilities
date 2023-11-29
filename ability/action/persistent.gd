extends BaseAction

var ability:Ability
var thinker_scene = load("res://entity/actor/thinker/thinker.tscn")
# Auxiliary actions are actions that contain another ability to be fired 
# when the event register is called

func setup(data_param:AbilityActionData):
	super(data_param)

	# Parse the new ability and set the internal ability to it
	var data_driven_ability = data_driven_ability_script.new()
	# TODO: Support multiple ablities to be added here
	ability = data_driven_ability.parse(self.data.trigger_abilities[0])

func execute(caster_ability:Ability, target:Actor, target_point:Vector2):
	# Add the ability to the caster's tree
	# The target is the caster of the ability
	var data_driven_ability = data_driven_ability_script.new()
	ability = data_driven_ability.parse(self.data.trigger_abilities[0])
	var caster = caster_ability.caster
	if target:
		caster = target
	else:
		var thinker_container_node = caster_ability.caster.get_tree().get_root().get_node("World/ThinkerContainer")
		caster = thinker_scene.instantiate()
		caster.global_position = target_point
		thinker_container_node.call_deferred("add_child", caster)
		await caster.ready
		ability.connect("ability_action_finished", caster.work_complete)
	caster.add_child(ability)

	# Attempt to execute the ability with updated params
	ability.execute(caster, {'target_unit':target, 'target_position': target_point})
