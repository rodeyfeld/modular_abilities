extends CharacterBody2D

class_name Entity

@onready var controller:Node = $Controller
const data_driven_ability_script = preload("res://ability/data_driven_ability.gd")
var abilities = {}
#The base class for all entities, including spells, characters

func _physics_process(_delta):

	if controller.controller_script:
		controller.controller_script.update(self)
		
