extends Entity

class_name Beam

@export var initial_speed:float = 0
@export var initial_direction:Vector2 = Vector2.ZERO
@export var initial_arc:float = 0.0
@export var curr_push = 0.0
@export var curr_angle:float = 0.0
@export var distance:float = 0.0
signal projectile_hit
signal projectile_timeout
@onready var projectile_timeout_timer = $ProjectileTimeoutTimer
var projectile_owner:Actor
var point_at_distance_x
var point_at_distance_y
@onready var beam_line = $Line2D

func fire(p_owner, _timeout = -1):
	projectile_owner = p_owner 
	$ProjectileTimeoutTimer.call_deferred("start", _timeout)

func create_line(p_owner):
	beam_line.add_point(self.position)
	pass
