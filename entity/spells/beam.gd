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
@onready var beam_timeout_timer:Timer = $BeamTimeoutTimer
var caster:Actor
@onready var beam_line = $Line2D



func fire():
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

func create_line(end_point):
	beam_line.add_point(to_local(global_position))
	beam_line.add_point(end_point)
	

func _on_hitbox_area_entered(area):
	if area.get_parent() != caster:
		emit_signal("projectile_hit", area.owner)
		self.queue_free()

func _on_projectile_timeout_timer_timeout():
	emit_signal("projectile_timeout", self.global_position)
	self.queue_free()