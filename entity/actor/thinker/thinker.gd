extends Actor

class_name Thinker

@onready var thinker_controller_script = preload("res://controllers/thinker_controller.gd")

func _ready():
	title = "thinker"
	controller.controller_script = thinker_controller_script.new()
	# Configure deadzone for mouse
#	var angle = self.get_angle_to(get_global_mouse_position())
#	var distance = 100

func work_complete():
	print(self.title, self, " THINKER_DONE")
	self.queue_free()
