extends Actor

class_name Thinker

@onready var thinker_controller_script = preload("res://controllers/thinker_controller.gd")

func _ready():
	title = "thinker"
	controller.controller_script = thinker_controller_script.new()
	var data_driven_ability = data_driven_ability_script.new()
	for ability in abilities.values():
		var parsed_ability = data_driven_ability.parse(ability)
		add_child(parsed_ability)
	# Configure deadzone for mouse
#	var angle = self.get_angle_to(get_global_mouse_position())
#	var distance = 100




func work_complete():
	print(self.title, self, " THINKER_DONE")
	self.queue_free()
