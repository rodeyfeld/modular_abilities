extends BaseAction

const projectile_scene = preload("res://entity/spell_projectiles/projectile.tscn")

var speed:int

signal projectile_hit

func setup(data_param:AbilityActionData):
	super(data_param)
	# TODO: Replace this with dictionary
	for field in self.data.int_fields:
		# Set the internal speed to the data param speed
		if field.name == 'speed':
			speed = field.value

# TODO: Consider passing this information to the projectile speed/direction/position
# and handle its logic there. 
func execute(caster_ability:Ability, target:Actor, target_position:Vector2):
	# Get the position for this offensive ability
	var attach_node:Node2D = caster_ability.caster.get_node("AttachPoint/AbilityOffensiveAttachPoint")
	var attach_global_position:Vector2 = attach_node.global_position
	
	# Create our projectile and add it to the container for projectiles
	var projectile:Projectile = projectile_scene.instantiate()
	var projectile_container_node = caster_ability.caster.get_tree().get_root().get_node("World/ProjectileContainer")
	projectile_container_node.call_deferred("add_child", projectile)

	# Set the projectile's global_position to its attach_point
	projectile.global_position = attach_global_position
	# Connect the signal "projectile_hit" to this projectile, this will call the 
	# on_projectile_hit function in the ability when the "projectile_hit" signal is
	# emitted. See _on_hitbox_area_entered in "res://entity/spell_projectiles/projectile.gd"
	projectile.connect("projectile_hit", caster_ability.on_projectile_hit)
	var dir:Vector2 = target_position - attach_global_position
	# Configure its direction and speed
	projectile.initial_speed = speed
	projectile.initial_direction = dir
	# Fire the projectile
	projectile.fire()
