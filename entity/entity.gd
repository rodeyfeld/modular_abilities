extends CharacterBody2D

class_name Entity

@onready var controller:Node = $Controller
#The base class for all entities, including spells, characters
func _physics_process(delta):

	if controller.controller_script:
		controller.controller_script.update(self)
		
