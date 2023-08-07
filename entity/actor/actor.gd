extends Entity

class_name Actor

# Class for containing all entities that can be interacted with and interact

@onready var detection_zone:Area2D = $UnitDetectionZone
@onready var ability_attach_point:Node2D = $AttachPoint

var attach_point_scene = load("res://entity/actor/attach_point.tscn")
var health:int
var title:String
var nearby_targetable_units = []
var DEADZONE:float = 100.0

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

func create_linear_attach_point(dir):
	var attach_point:AttachPoint = attach_point_scene.instantiate()
	ability_attach_point.add_child(attach_point)
	var angle = self.get_angle_to(dir)
	print(dir)
	attach_point.global_position.x = DEADZONE * cos(angle) + self.position.x
	attach_point.global_position.y = DEADZONE * sin(angle) + self.position.y

	return attach_point
	
func create_nova_attach_point(num, num_required):
	var angle_rad = (TAU / num_required) * num

	var attach_point:AttachPoint = attach_point_scene.instantiate()
	ability_attach_point.add_child(attach_point)
	attach_point.title_label.text = str(num)
	attach_point.global_position.x = DEADZONE * cos(angle_rad) + self.position.x
	attach_point.global_position.y = DEADZONE * sin(angle_rad) + self.position.y
	return attach_point

func create_spread_attach_point(dir, num, num_required, angle_between_shots):
	
	var attach_point:AttachPoint = attach_point_scene.instantiate()
	ability_attach_point.add_child(attach_point)
	
	var target_angle = rad_to_deg(self.get_angle_to(dir))
	var total_angle = angle_between_shots * num_required
	print(num)
	print(total_angle/num)
	
	var wedge = num * angle_between_shots
	var start_angle = total_angle / 2  
#	var curr_angle = 0
	var curr_angle = (target_angle - start_angle + wedge) 
#	var curr_angle = (((num_required - num) * angle_between_shots) + (total_angle / num)
	
	
	
#
#
#
#
#
#
#
#
#
#	var even_bit = 1 if (floor(num_required) % 2) == 0 else 0
#	var flip_bit = -1 if floor(int(num) / int(num_required)) == 0 else 1
#
#	var curr_angle = target_angle + (num * angle_between_shots)
#	if even_bit:
#
#		pass
#
#	var test_angle = target_angle + (angle_between_shots * flip_bit)
	var rad_angle = deg_to_rad(curr_angle)
	
	
	attach_point.global_position.x = DEADZONE * cos(rad_angle) + self.position.x
	attach_point.global_position.y = DEADZONE * sin(rad_angle) + self.position.y
	
	return attach_point
#	var middle_offset = angle_between_shots if (num_required % 2) == 0 else 0
#	var DEADZONE = 100
#	var total_angle_difference = num_required * angle_between_shots
#	var attach_point:AttachPoint = attach_point_scene.instantiate()
#	var curr_angle = 0 
#	var flip_bit = 0
#	if (num_required / num) <= 2:
#		flip_bit = 1
#	else:
#		flip_bit = -1
#

