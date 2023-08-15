extends Actor

class_name Thinker


func _ready():
	title = "thinker"

	# Configure deadzone for mouse
#	var angle = self.get_angle_to(get_global_mouse_position())
#	var distance = 100

func work_complete():
	print(self.title, self, " THINKER_DONE")
	self.queue_free()
