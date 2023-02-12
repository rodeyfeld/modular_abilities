extends Entity

class_name Actor

# Class for containing all entities that can be interacted with and interact

@onready var detection_zone:Area2D = $UnitDetectionZone
var health:int
var title:String
var nearby_targetable_units = []
var ability_offensive_attach_point_distance:float = 100.0


func update_health(amount, _title):
	# Any time this function called, it will update the health and provide 
	# a title for what caused it
	print("HEALTH_BEFORE: ", health)
	health += amount
	print("HEALTH_AFTER: ", health)

func get_nearby_targets():
	var bodies:Array[Node2D] = []
	for body in detection_zone.get_overlapping_bodies():
		if self.get_instance_id() != body.get_instance_id():
			bodies.append(body)
	return bodies
	

func _on_unit_detection_zone_body_entered(body):
	# Collect nearby targetable actors
	if self.get_instance_id() != body.get_instance_id():
		nearby_targetable_units.append(body)

func _on_unit_detection_zone_body_exited(body):
	# Remove actor if they have left the targets radius
	nearby_targetable_units.erase(body)
