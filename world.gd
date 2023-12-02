extends Node2D

@onready var player = $PlayerContainer/Player
@onready var enemy_container = $EnemyContainer
@onready var mouse_indicator = $MouseIndicator
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	for enemy in enemy_container.get_children():
		#add ai controller
		pass

func _physics_process(delta):
	mouse_indicator.global_position = get_global_mouse_position()
