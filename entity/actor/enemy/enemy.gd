extends Actor

class_name Enemy

func _ready():
	title = "enemy" + str(self.get_instance_id())
	await get_tree().process_frame


func _on_hurtbox_area_entered(area):
	emit_signal("projectile_hit", area.owner)
