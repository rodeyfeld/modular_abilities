extends BaseAction

const projectile_scene = preload("res://entity/spell_projectiles/projectile.tscn")

var speed:float

signal projectile_hit

func setup(data_param:AbilityActionData):
	super(data_param)

	speed = self.data.attribute_fields.speed

# TODO: Consider passing this information to the projectile speed/direction/position
# and handle its logic there. 
func execute(caster_ability:Ability, _target:Actor, target_position:Vector2):
	# Get the position for this offensive ability
	var firing_mode:DataDrivenAbilitySingleton.attribute_field_fire_mode_type = self.data.attribute_fields.attribute_field_fire_data.attribute_field_fire_mode_type
	
	var attach_node:Node2D
	var initial_angle:Vector2 = Vector2.ZERO
	for num in range(self.data.attribute_fields.attribute_field_fire_data.num_to_fire_per_execution):
		var projectile:Projectile = projectile_scene.instantiate()
		var projectile_container_node = caster_ability.caster.get_tree().get_root().get_node("World/ProjectileContainer")
		var dir:Vector2 = Vector2.ZERO
		projectile_container_node.call_deferred("add_child", projectile)

		# Set the projectile's global_position to its attach_point
		# Connect the signal "projectile_hit" to this projectile, this will call the 
		# on_projectile_hit function in the ability when the "projectile_hit" signal is
		# emitted. See _on_hitbox_area_entered in "res://entity/spell_projectiles/projectile.gd"
		projectile.connect("projectile_hit", caster_ability.on_projectile_hit)
		if firing_mode == DataDrivenAbilitySingleton.attribute_field_fire_mode_type.NOVA:
			attach_node = caster_ability.caster.create_nova_attach_point(num, self.data.attribute_fields.attribute_field_fire_data.num_to_fire_per_execution)
			dir = attach_node.position
		elif firing_mode == DataDrivenAbilitySingleton.attribute_field_fire_mode_type.CONE:
			pass
		elif firing_mode == DataDrivenAbilitySingleton.attribute_field_fire_mode_type.LINEAR:
			# Create our projectile and add it to the container for projectiles
			attach_node = caster_ability.caster.get_node("AttachPoint/AbilityOffensiveAttachPoint")
			dir = target_position - attach_node.global_position
		projectile.global_position = attach_node.global_position
		
		# Configure its direction and speed
		projectile.initial_speed = speed
		projectile.initial_direction = dir
		# Fire the projectile
		projectile.fire(caster_ability.caster)
