extends BaseAction

var ability:Ability
var thinker_scene = load("res://entity/actor/thinker/thinker.tscn")
# Auxiliary actions are actions that contain another ability to be fired 
# when the event register is called

func setup(data_param:AbilityActionData):
	super(data_param)
	

func execute(caster_ability:Ability, target:Actor, target_point:Vector2):
	# Add the ability to the caster's tree
	# The target is the caster of the ability
	var data_driven_ability = data_driven_ability_script.new()
	var caster = caster_ability.caster
	for i in range(len(self.data.trigger_abilities)):
		if target:
			ability = data_driven_ability.parse(self.data.trigger_abilities[i])
			caster = target
			caster.add_child(ability)
			ability.execute(caster, {'target_unit':target, 'target_position': target_point})
		else:
			var thinker_container_node = caster_ability.caster.get_tree().get_root().get_node("World/ThinkerContainer")
			var thinker:Thinker = thinker_scene.instantiate()
			thinker.abilities[i] = self.data.trigger_abilities[i]
			thinker.global_position = target_point
			thinker_container_node.call_deferred("add_child", thinker)


