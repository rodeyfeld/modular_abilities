extends Entity

class_name Beam

@export var initial_speed:float = 0
@export var initial_direction:Vector2 = Vector2.ZERO
@export var initial_arc:float = 0.0
@export var curr_push = 0.0
@export var curr_angle:float = 0.0
@export var timeout:float = 0.0
@export var distance:float = 0.0
signal projectile_hit
signal projectile_timeout
@onready var raycast:RayCast2D = $RayCast2D
@onready var hitbox_collision_shape = $Hitbox/CollisionShape2d
@onready var beam_timeout_timer:Timer = $BeamTimeoutTimer
var caster:Actor
@onready var beam_line = $Line2D
var thinker_scene = preload("res://entity/actor/thinker/thinker.tscn")

func get_midpoint(v1:Vector2, v2:Vector2) -> Vector2:
	return Vector2(((v1.x + v2.x) / 2), ((v1.y + v2.y) / 2))
	
func fire(persistent_abilities):
	var end_point = initial_direction * distance
	await self.ready
	beam_timeout_timer.start()
	raycast.target_position = end_point
	raycast.force_raycast_update()
	var collision_point = raycast.get_collision_point()

	if collision_point:
		create_line(to_local(collision_point))
	else:
		create_line(end_point)

	for persistent_ability in persistent_abilities:
		var thinker:Thinker = thinker_scene.instantiate()
		thinker.abilities[persistent_ability.get_instance_id()] = persistent_ability
		add_child(thinker)
		

func create_line(end_point):
	var start_point = self.to_local(self.global_position)

	
	beam_line.add_point(start_point)
	beam_line.add_point(end_point)
	
	for i in beam_line.points.size() - 1:
		var new_shape = CollisionShape2D.new()
		$Hitbox.add_child(new_shape)
		var rect = RectangleShape2D.new()
		new_shape.position = (beam_line.points[i] + beam_line.points[i + 1]) / 2
		new_shape.rotation = beam_line.points[i].direction_to(beam_line.points[i + 1]).angle()
		var length = beam_line.points[i].distance_to(beam_line.points[i + 1])
		rect.extents = Vector2(length / 2, 10)
		new_shape.shape = rect


func _on_hitbox_area_entered(area):
	if area.get_parent() != caster:
		emit_signal("projectile_hit", area.owner)
		self._queue_free()
	
func _on_projectile_timeout_timer_timeout():
	emit_signal("projectile_timeout", self.global_position)
	self._queue_free()
	
func _queue_free():
	$AnimationPlayer.play("fade")
	await $AnimationPlayer.animation_finished
	self.queue_free()
	
