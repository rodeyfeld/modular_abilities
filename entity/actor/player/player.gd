extends Entity

class_name Player

var fyreball = preload("res://ability/fyreball.tres")
var data_driven_ability_script = load("res://ability/data_driven_ability.gd")


func _ready():
	print(health)
	var data_driven_ability = data_driven_ability_script.new()
	var ability:Ability = data_driven_ability.parse(fyreball)
	ability.execute(self, [self, Vector2(0,0)])
	print(health)
	
	
	
