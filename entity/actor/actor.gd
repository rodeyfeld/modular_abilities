extends Entity

class_name Actor

var nearby_targetable_units = []
var health:int
var title:String



func update_health(amount, _title):
	print(health)
	health += amount
	print(health)
	
func set_initial_overlapping_areas():
	nearby_targetable_units = get_node("NearbyUnitArea").get_overlapping_areas()
	print("OVERLAP: ", nearby_targetable_units)

func _physics_process(delta):
	print("ACTOR: ", get_node("NearbyUnitArea").get_overlapping_areas())


func _on_unit_detection_zone_body_entered(body):
	nearby_targetable_units.append(body)


func _on_unit_detection_zone_body_exited(body):
	nearby_targetable_units.erase(body)
