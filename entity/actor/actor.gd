extends Entity

class_name Actor

var nearby_allied_units = []
var health:int
var title:String



func update_health(amount, _title):
	print(health)
	health += amount
	print(health)
	
func set_initial_overlapping_areas():
	nearby_allied_units = get_node("NearbyUnitArea").get_overlapping_areas()
	print("OVERLAP: ", nearby_allied_units)

func _on_area_2d_2_body_entered(body):
	nearby_allied_units.append(body)
	
func _on_area_2d_2_body_exited(body):
	nearby_allied_units.erase(body)
	
func _physics_process(delta):
	print("ACTOR: ", get_node("NearbyUnitArea").get_overlapping_areas())
