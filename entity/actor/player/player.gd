extends Entity

class_name Player

var fyreball = preload("res://ability/fyreball.tres")
var data_driven_ability_script = load("res://ability/data_driven_ability.gd")


func _ready():
	var data_driven_ability = data_driven_ability_script.new()
	data_driven_ability.parse(fyreball)
	print(fyreball.ability_data)
	
