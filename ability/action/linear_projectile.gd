extends BaseAction

const projectile_scene = preload("res://entity/spells/projectile.tscn")

var speed:float
var initial_arc:float


func setup(data_param:AbilityActionData):
	super(data_param)

	speed = self.data.attribute_fields.speed
	
	initial_arc = self.data.attribute_fields.attribute_field_fire_data.arc

# TODO: Consider passing this information to the projectile speed/direction/position
# and handle its logic there. 
func execute(caster_ability:Ability, _target:Actor, target_position:Vector2):
	# Get the position for this offensive ability
#	var firing_mode:DataDrivenAbilitySingleton.attribute_field_fire_mode_type = self.data.attribute_fields.attribute_field_fire_data.attribute_field_fire_mode_type

	for num in range(self.data.attribute_fields.attribute_field_fire_data.num_to_fire_per_execution):
		var dir:Vector2 = Vector2.ZERO
		var projectile:Projectile = projectile_scene.instantiate()
		var projectile_container_node = caster_ability.caster.get_tree().get_root().get_node("World/ProjectileContainer")
		projectile_container_node.call_deferred("add_child", projectile)

		# Connect the signal "projectile_hit" to this projectile, this will call the 
		# on_projectile_hit function in the ability when the "projectile_hit" signal is
		# emitted. See _on_hitbox_area_entered in "res://entity/spell_projectiles/projectile.gd"
		projectile.connect("projectile_hit", caster_ability.on_projectile_hit)
		projectile.connect("projectile_timeout", caster_ability.on_projectile_timeout)
		var attach_node:AttachPoint = caster_ability.caster.get_attach_node(num, target_position, self.data.attribute_fields)
		dir = attach_node.position
		projectile.global_position = attach_node.global_position
		
		# Configure its direction and speed
		projectile.initial_speed = speed
		projectile.initial_direction = dir
		projectile.initial_arc = initial_arc
		# Fire the projectile
		projectile.fire(
			caster_ability.caster,
			self.data.attribute_fields.attribute_field_fire_data.timeout
		)
		# Free the attach node 
		#attach_node.queue_free()
