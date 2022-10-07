extends Actor

class_name Enemy

func _ready():
	title = "enemy" + str(self.get_instance_id())
	await get_tree().process_frame
#	nearby_targetable_units = get_node("UnitDetectionZone").get_overlapping_areas()
#	print(nearby_targetable_units)

func _on_hurtbox_area_entered(area):
	var test = area.owner
	emit_signal("projectile_hit", area.owner)
