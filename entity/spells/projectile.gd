extends Entity

class_name Projectile

@export var initial_speed:float = 0
@export var initial_direction:Vector2 = Vector2.ZERO
@export var initial_arc:float = 0.0
@export var curr_push = 0.0
@export var curr_angle:float = 0.0

signal projectile_hit
signal projectile_timeout
@onready var projectile_timeout_timer = $ProjectileTimeoutTimer
var projectile_owner:Actor
var point_at_distance_x
var point_at_distance_y

func _ready():
	curr_push = initial_speed

func _physics_process(_delta):
	move_and_slide()

func fire(p_owner, _timeout = -1):
	projectile_owner = p_owner 
	$ProjectileTimeoutTimer.call_deferred("start", _timeout)
	velocity = initial_direction.normalized() * initial_speed

func on_hit():
	pass

func _on_hitbox_area_entered(area):
	if area.get_parent() != projectile_owner:
		emit_signal("projectile_hit", area.owner)
		self.queue_free()

func _on_projectile_timeout_timer_timeout():
	emit_signal("projectile_timeout", self.global_position)
	self.queue_free()
