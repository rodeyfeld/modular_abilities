extends Node

class_name PlayerController



func update(actor): 
	
	if Input.is_anything_pressed():
		var abilities = actor.abilities
		for ability in abilities:
		
			if Input.is_action_just_pressed(ability):
				print(actor.get_global_mouse_position())
				if abilities[ability]['ability'].cooldown_timer.time_left <= 0:
					abilities[ability]['ability'].execute(
						actor,
				 		{
							'target_unit':actor,
						 	'target_position': actor.get_global_mouse_position()
						}
					)

