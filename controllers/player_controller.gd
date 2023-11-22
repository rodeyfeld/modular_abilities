extends Node

class_name PlayerController

func update(actor):
	
	if Input.is_anything_pressed():
		var abilities = actor.abilities
		for ability in abilities:
		
			if Input.is_action_just_pressed(ability):
				abilities[ability]['ability'].execute(
					actor,
			 		{
						'target_unit':actor,
					 	'target_position': actor.get_global_mouse_position()
					}
				)
