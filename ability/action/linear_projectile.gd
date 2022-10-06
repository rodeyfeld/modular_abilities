extends BaseAction

const projectile_scene = preload("res://entity/spell_projectiles/projectile.tscn")

var speed:int

signal projectile_hit

func setup(data_param:AbilityActionData):
	super(data_param)
	for field in self.data.int_fields:
		if field.name == 'speed':
			speed = field.value

func execute(caster_ability:Ability, target:Actor, target_position:Vector2):
	var attach_node:Node2D = caster_ability.caster.get_node("AttachPoint/AbilityOffensiveAttachPoint")
	var attach_global_position:Vector2 = attach_node.global_position
	
	var projectile:Projectile = projectile_scene.instantiate()
	var projectile_container_node = caster_ability.caster.get_tree().get_root().get_node("World/ProjectileContainer")
	projectile_container_node.call_deferred("add_child", projectile)
#	var projectile_controller:ProjectileController = entity.get_node("projectile_controller")
#	target_point.y = attach_global_position.y
	projectile.global_position = attach_global_position
	projectile.connect("projectile_hit", caster_ability.on_projectile_hit)
	var dir:Vector2 = target_position - attach_global_position
	projectile.initial_speed = speed
	projectile.initial_direction = dir
	projectile.fire()
