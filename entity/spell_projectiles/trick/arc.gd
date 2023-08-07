extends Projectile

class_name Arc



func _physics_process(_delta):
	move_and_slide()


func fire(p_owner, _timeout = -1):
	projectile_owner = p_owner
	
	$ProjectileTimeoutTimer.call_deferred("start", _timeout)
	velocity = initial_direction.normalized() * initial_speed

func on_hit():
	pass
