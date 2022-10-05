extends Entity

class_name Projectile

@export var initial_speed:int = 0
@export var initial_direction:Vector2 = Vector2.ZERO

func _physics_process(delta):
	move_and_slide()

func fire():
	print(initial_direction, initial_speed)
	velocity = initial_direction * initial_speed
	print(velocity)
