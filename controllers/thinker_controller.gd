extends Node

class_name ThinkerController

var follow_target = null 


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
	if is_instance_valid(follow_target):
		actor.global_position = follow_target.global_position
