extends Entity

class_name Projectile

@export var initial_speed:int = 0
@export var initial_direction:Vector2 = Vector2.ZERO

signal projectile_hit

func _physics_process(delta):
	move_and_slide()

func fire():
	velocity = initial_direction.normalized() * initial_speed

func on_hit():
	pass


func _on_area_2d_area_entered(area):
#	print("HI")
	var test = area.get_root()
	emit_signal("projectile_hit", area.get_tree().get_root())
