extends Actor

class_name Enemy

func _ready():
	title = "enemy"
	await get_tree().process_frame
	nearby_allied_units = get_node("NearbyUnitArea").get_overlapping_areas()
	print(nearby_allied_units)

func _on_area_2d_area_entered(area):
#	print("HI")
	var test = area.owner
	emit_signal("projectile_hit", area.owner)

func _physics_process(delta):
	print("ENEMY:", nearby_allied_units)
