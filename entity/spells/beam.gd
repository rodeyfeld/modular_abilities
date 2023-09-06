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

func get_midpoint(v1:Vector2, v2:Vector2) -> Vector2:
	return Vector2(((v1.x + v2.x) / 2), ((v1.y + v2.y) / 2))
	
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
	var start_point = self.to_local(self.global_position)
	var midpoint = self.get_midpoint(start_point, end_point)
	
	var angle = fmod((self.get_angle_to(end_point) - PI), (2 * PI))
	
	var segment = SegmentShape2D.new()
	segment.a = start_point
	segment.b = end_point
	hitbox_collision_shape.shape = segment
	
	
	beam_line.add_point(start_point)
	beam_line.add_point(end_point)



func _on_hitbox_area_entered(area):
	if area.get_parent() != caster:
		emit_signal("projectile_hit", area.owner)
		self.queue_free()

func _on_projectile_timeout_timer_timeout():
	emit_signal("projectile_timeout", self.global_position)
	self.queue_free()
