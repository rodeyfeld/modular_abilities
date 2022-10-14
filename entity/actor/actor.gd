extends Entity

class_name Actor

var health:int
var title:String

var nearby_targetable_units = []
var ability_offensive_attach_point_distance:float = 100.0


func update_health(amount, _title):
	print(health)
	health += amount
	print(health)
	
func _on_unit_detection_zone_body_entered(body):
	if self.get_instance_id() != body.get_instance_id():
		nearby_targetable_units.append(body)

func _on_unit_detection_zone_body_exited(body):
	nearby_targetable_units.erase(body)
