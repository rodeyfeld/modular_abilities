extends BaseAction

const entity_scene = preload("res://entity/entity.tscn")

var speed:int


func setup(data_param:AbilityActionData):
	super(data_param)
	for field in self.data.int_fields:
		if field.name == 'speed':
			speed = field.value

func execute(caster_ability:Ability, target:Entity, target_point:Vector2):
	var attach_node:Node2D = caster_ability.caster.get_node("attach_point/ability_offensive_attach_point")
	var attach_position:Vector2 = attach_node.position
	
	var entity:Entity = entity_scene.instantiate()
	attach_node.add_child(entity)
	var projectile_controller:ProjectileController = entity.get_node("projectile_controller")
	print(caster_ability.caster.global_position)
	print(attach_node.global_position)
	print(entity.global_position)

	target_point.y = attach_position.y
	var dir:Vector2 = target_point - attach_position
