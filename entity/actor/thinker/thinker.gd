extends Actor

class_name Thinker

@onready var thinker_controller_script = preload("res://controllers/thinker_controller.gd")
var follow_target

func _ready():
	title = "thinker"
	controller.controller_script = thinker_controller_script.new()
	var data_driven_ability = data_driven_ability_script.new()
	for ability in abilities:
		
		abilities[ability] = data_driven_ability.parse(abilities[ability])
		add_child(abilities[ability])
		if not abilities[ability].channelled:
			abilities[ability].connect("ability_action_finished", work_complete)
	# Configure deadzone for mouse
#	var angle = self.get_angle_to(get_global_mouse_position())
#	var distance = 100
	

func work_complete(target_pos=null):
	print(self.title, self, " THINKER_DONE")
	self.queue_free()
