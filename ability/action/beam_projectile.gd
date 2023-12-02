extends BaseAction

const beam_scene = preload("res://entity/spells/beam.tscn")

var distance:float
var persistent_abilities:Array[Ability]


func setup(data_param:AbilityActionData):
	super(data_param)

	
	
	distance = self.data.attribute_fields.attribute_field_fire_data.max_distance

# TODO: Consider passing this information to the beam speed/direction/position
# and handle its logic there. 
func execute(caster_ability:Ability, _target:Actor, target_position:Vector2):
	# Get the position for this offensive ability
#	var firing_mode:DataDrivenAbilitySingleton.attribute_field_fire_mode_type = self.data.attribute_fields.attribute_field_fire_data.attribute_field_fire_mode_type

	for num in range(self.data.attribute_fields.attribute_field_fire_data.num_to_fire_per_execution):
		var dir:Vector2 = Vector2.ZERO
		var beam:Beam = beam_scene.instantiate()
		var beam_container_node = caster_ability.caster.get_tree().get_root().get_node("World/ProjectileContainer")
		beam_container_node.call_deferred("add_child", beam)

		# Connect the signal "beam_hit" to this projectile, this will call the 
		# on_projectile_hit function in the ability when the "projectile_hit" signal is
		# emitted. See _on_hitbox_area_entered in "res://entity/spell_projectiles/projectile.gd"
		beam.connect("projectile_hit", caster_ability.on_projectile_hit)
		beam.connect("projectile_timeout", caster_ability.on_projectile_timeout)
		var attach_node:AttachPoint = caster_ability.caster.get_attach_node(num, target_position, self.data.attribute_fields)
		beam.global_position = attach_node.global_position
		
		# Configure its direction and speed
		beam.distance = distance
		beam.initial_direction = target_position
		beam.caster = caster_ability.caster
		beam.timeout = self.data.attribute_fields.attribute_field_fire_data.timeout
		beam.fire(self.data.persistent_abilities)
		# Free the attach node 
		attach_node.queue_free()
