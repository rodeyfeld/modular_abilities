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
var thinker_scene = preload("res://entity/actor/thinker/thinker.tscn")
var projectile_owner:Actor
var point_at_distance_x
var point_at_distance_y

func _ready():
	curr_push = initial_speed

func _physics_process(_delta):
	move_and_slide()

func fire(p_owner, _timeout = -1, persistent_abilities=[]):
	await self.ready
	projectile_owner = p_owner 
	$ProjectileTimeoutTimer.call_deferred("start", _timeout)
	velocity = initial_direction.normalized() * initial_speed

	#for persistent_ability in persistent_abilities:
	for i in range(len(persistent_abilities)):
		var thinker:Thinker = thinker_scene.instantiate()
		var thinker_container_node = get_tree().get_root().get_node("World/ThinkerContainer")
		thinker.abilities[i] = persistent_abilities[i]
		thinker.global_position = self.global_position
		#get_midpoint(beam_line.points[0], beam_line.points[1])
		thinker_container_node.call_deferred("add_child", thinker)
		self.connect("projectile_timeout", thinker.work_complete)
		self.connect("projectile_hit", thinker.work_complete)
		await thinker.ready
		thinker.controller.controller_script.follow_target = self

func on_hit():
	pass

func _on_hitbox_area_entered(area):
	if area.get_parent() != projectile_owner:
		emit_signal("projectile_hit", area.owner)
		self.queue_free()

func _on_projectile_timeout_timer_timeout():
	emit_signal("projectile_timeout", self.global_position)
	self.queue_free()
