extends Node

class_name ThinkerController

func update(actor):
	
	var abilities = actor.abilities
	for ability in abilities.values():
		if ability.cooldown_timer.time_left <= 0:
			ability.execute(
				actor,
		 		{
					'target_unit':actor,
				 	'target_position': actor.global_position
				}
			)
