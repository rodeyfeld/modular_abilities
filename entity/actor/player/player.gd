extends Entity

class_name Player

var fyreball = preload("res://ability/fyreball.tres")
var data_driven_ability_script = load("res://ability/data_driven_ability.gd")
var ability:Ability

func _ready():
	var data_driven_ability = data_driven_ability_script.new()
	ability = data_driven_ability.parse(fyreball)
	add_child(ability)
	
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		ability.execute(self, [self, Vector2(0,0)])
	
	
	
